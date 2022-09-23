//
//  ProjectManagementViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/12.
//

import UIKit

final class ProjectManagementViewController: UIViewController {
    // MARK: - Properties
    
    private let projectManagementView = ProjectManagementView()
    private let projectManagermentViewModel = ProjectManagermentViewModel()
    weak var delegate: ProjectManagementViewControllerDelegate?
    var item: ProjectViewModel?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(projectManagementView)
        view.backgroundColor = .systemBackground
        
        configureNavigationItems()
        configureViewLayout()
    }
    
    // MARK: - Methods
    
    private func configureNavigationItems() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(rightBarButtonDidTap))
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: item == nil ? .cancel : .edit,
                                            target: self,
                                            action: #selector(leftBarButtonDidTap))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.title = item == nil ? ProjectState.todo.name : item?.workState.name
    }
    
    func configureViewItems(item: ProjectViewModel?) {
        guard let item = item else { return }
        self.item = item
        
        projectManagementView.configureItem(title: item.title,
                                            body: item.body)
    }
    
    @objc
    private func rightBarButtonDidTap() {
        if item == nil {
            let newItem = projectManagementView.makeItems()
            let data = projectManagermentViewModel.makeProjectViewModel(id: UUID().description,
                                                                        state: .todo,
                                                                        newItem: newItem)
            
            delegate?.projectManagementViewController(self,
                                                      createData: data)
        }
        
        dismiss(animated: true)
    }
    
    @objc
    private func leftBarButtonDidTap() {
        if let item = self.item {
            let newItem = projectManagementView.makeItems()
            let data = projectManagermentViewModel.makeProjectViewModel(id: item.id,
                                                                        state: item.workState,
                                                                        newItem: newItem)
            
            delegate?.projectManagementViewController(self,
                                                      updateData: data)
            
            return
        }
        
        dismiss(animated: true)
    }
    
    private func configureViewLayout() {
        NSLayoutConstraint.activate(
            [
                projectManagementView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                projectManagementView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                projectManagementView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                projectManagementView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
