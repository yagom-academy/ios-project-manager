//
//  ManageWorkViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit

final class ManageWorkViewController: UIViewController {
    private enum ViewMode {
        case add
        case edit
    }
    
    private let workManageView = WorkManageView()
    private var viewModel: WorkViewModel?
    private var viewMode: ViewMode = .edit
    
    override func loadView() {
        super.loadView()
        self.view = workManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let cancleBarButton = UIBarButtonItem(title: "Cancle",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelBarButtonTapped))
        let doneBarButton = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(doneBarButtonTapped))
        let editBarButton = UIBarButtonItem(title: "Edit",
                                            style: .done,
                                            target: self,
                                            action: #selector(editBarButtonTapped))
        switch viewMode {
        case .add:
            self.navigationItem.leftBarButtonItem = cancleBarButton
            self.navigationItem.title = "TODO"
        case .edit:
            self.navigationItem.leftBarButtonItem = editBarButton
            self.navigationItem.title = "Edit"
        }
        
        self.navigationItem.rightBarButtonItem = doneBarButton
    }
    
    @objc private func doneBarButtonTapped() {
        guard let viewModel = viewModel else { return }
        guard let newWork = workManageView.createNewWork() else { return }
        
        viewModel.todoWorks.accept([newWork] + viewModel.todoWorks.value)
        
        self.dismiss(animated: true)
    }
    
    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func editBarButtonTapped() {
        workManageView.changeEditMode(true)
    }
    
    func configureAddMode(_ viewModel: WorkViewModel) {
        self.viewModel = viewModel
        viewMode = .add
    }
    
    func configureEditMode(with work: Work, _ viewModel: WorkViewModel) {
        workManageView.configure(with: work)
        workManageView.changeEditMode(false)
        self.viewModel = viewModel
    }
}
