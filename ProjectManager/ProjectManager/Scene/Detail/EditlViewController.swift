//
//  EditlViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxSwift
import RxCocoa

final class EditlViewController: UIViewController {
    private let viewModel: EditViewModel
    
    init(viewModel: EditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let detailView = DetailView()
    private var disposebag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setEditView(viewModel.list)
        bindView()
    }
    
    private func bindView() {
        detailView.titleTextField.rx
            .text.changed
            .bind(onNext: { [weak self] in
                self?.viewModel.changeTitle($0)
            })
            .disposed(by: disposebag)
        
        detailView.deadlinePicker.rx
            .date.changed
            .bind(onNext: { [weak self] in
                self?.viewModel.changeDaedLine($0)
            })
            .disposed(by: disposebag)
        
        detailView.bodyTextView.rx
            .text.changed
            .bind(onNext: { [weak self] in
                self?.viewModel.changeBody($0)
            })
            .disposed(by: disposebag)
        
        detailView.doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchDoneButton()
                self?.dismiss(animated: true)
            })
            .disposed(by: disposebag)
        
        detailView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.tapLeftButton()
            })
            .disposed(by: disposebag)
    }
    
    private func tapLeftButton() {
        if detailView.leftButton.title == "Cancel" {
            self.dismiss(animated: true)
        }
        detailView.leftButton.title = "Cancel"
        detailView.changeEditable()
    }
}
