//
//  ManageWorkViewController.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/09.
//

import UIKit

final class ManageWorkViewController: UIViewController {
    private let workManageView = WorkManageView()
    private var viewModel: WorkViewModel?
    
    override func loadView() {
        super.loadView()
        self.view = workManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TODO"
        configureBarButton()
    }
    
    private func configureBarButton() {
        let cancleBarButton = UIBarButtonItem(title: "Cancle",
                                              style: .plain,
                                              target: self,
                                              action: #selector(cancelBarButtonTapped))
        let doneBarButton = UIBarButtonItem(title: "Done",
                                            style: .done,
                                            target: self,
                                            action: #selector(doneBarButtonTapped))
        
        self.navigationItem.leftBarButtonItem = cancleBarButton
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
    
    func configureAddMode(_ viewModel: WorkViewModel) {
        self.viewModel = viewModel
    }
    
    func configureWork(_ work: Work) {
        workManageView.configure(with: work)
    }
}
