//
//  EditlViewController.swift
//  ProjectManager
//
//  Created by 두기 on 2022/07/13.
//

import RxSwift
import RxCocoa

final class EditlViewController: UIViewController {
    private let viewModel: MainViewModelInOut
    private var listItem: ListItem
    
    init(viewModel:MainViewModelInOut ,listItem: ListItem) {
        self.viewModel = viewModel
        self.listItem = listItem
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
        detailView.setEditView(listItem)
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
        listItem.title = detailView.titleTextField.text ?? ""
        listItem.body = detailView.bodyTextView.text ?? ""
        listItem.deadline = detailView.deadlinePicker.date
        
        viewModel.updateList(listItem: listItem)
    }
    
    private func tapLeftButton() {
        if detailView.leftButton.title == "Cancel" {
            self.dismiss(animated: true)
        }
        detailView.leftButton.title = "Cancel"
        detailView.changeEditable()
    }
}
