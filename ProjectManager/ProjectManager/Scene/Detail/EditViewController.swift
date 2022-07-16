//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxSwift
import RxCocoa

final class EditViewController: UIViewController {
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
        detailView.setDetilView(viewModel.list)
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
                guard let self = self else {
                    return
                }
                let title = self.viewModel.touchLeftButton(self)
                self.detailView.leftButton.title = title
            })
            .disposed(by: disposebag)
    }
}
