//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxSwift
import RxCocoa

final class EditViewController: UIViewController {
    private let viewModel: EditViewModelable
    
    init(viewModel: EditViewModelable) {
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
        viewModel.isEditable
            .bind(onNext: { [weak self] in
            self?.detailView.titleTextField.isEnabled = $0
            self?.detailView.deadlinePicker.isUserInteractionEnabled = $0
            self?.detailView.bodyTextView.isEditable = $0
            
            self?.detailView.leftButton.title = $0 ? "Cancel" : "Edit"
        })
        .disposed(by: disposebag)
        
        detailView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchLeftButton()
            })
            .disposed(by: disposebag)
        
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
            })
            .disposed(by: disposebag)
        
        viewModel.dismiss.bind(onNext: { [weak self] in
            self?.dismiss(animated: true)
        })
        .disposed(by: disposebag)
        
        viewModel.showErrorAlert.bind(onNext: {[weak self] in
            self?.showErrorAlert(message: $0)
        })
        .disposed(by: disposebag)
    }
}
