//
//  ProjectManagementViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/12.
//

import UIKit

final class ProjectManagementViewController: UIViewController {
    // MARK: - Properties
    
    private let detailView = ProjectManagementView()
    private let viewModel = ProjectManagermentViewModel()
    private var item: ProjectViewModel?
    weak var delegate: ProjectManagementViewControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationItems()
        configureViewLayout()
    }
    
    // MARK: - Methods
    
    func configureViewItem(item: ProjectViewModel?) {
        guard let item = item else { return }
        
        self.item = item
        
        detailView.configureItem(title: item.title,
                                 body: item.body,
                                 date: item.date.toDate())
    }
    
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
    
    @objc
    private func rightBarButtonDidTap() {
        if item == nil {
            let newItem = detailView.makeItems()
            let data = viewModel.makeProjectViewModel(id: UUID().description,
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
            let newItem = detailView.makeItems()
            let data = viewModel.makeProjectViewModel(id: item.id,
                                                      state: item.workState,
                                                      newItem: newItem)
            
            delegate?.projectManagementViewController(self,
                                                      updateData: data)
            
            return
        }
        
        dismiss(animated: true)
    }
    
    private func configureViewLayout() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate(
            [
                detailView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                detailView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                detailView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                detailView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
