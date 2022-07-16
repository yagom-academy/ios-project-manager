//
//  EditlViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxSwift
import RxCocoa

final class EditlViewController: UIViewController {
    private let viewModel: DetailViewModel
    
    init(viewModel:DetailViewModel) {
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
        bindButton()
    }
    
    private func bindButton() {
        detailView.doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.updateList()
                self?.dismiss(animated: true)
            })
            .disposed(by: disposebag)
        
        detailView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.tapLeftButton()
            })
            .disposed(by: disposebag)
    }
    
    
    private func updateList() {
        viewModel.list.title = detailView.titleTextField.text ?? ""
        viewModel.list.body = detailView.bodyTextView.text ?? ""
        viewModel.list.deadline = detailView.deadlinePicker.date
        
        viewModel.updateList(listItem: viewModel.list)
    }
    
    private func tapLeftButton() {
        if detailView.leftButton.title == "Cancel" {
            self.dismiss(animated: true)
        }
        detailView.leftButton.title = "Cancel"
        detailView.changeEditable()
    }
}
