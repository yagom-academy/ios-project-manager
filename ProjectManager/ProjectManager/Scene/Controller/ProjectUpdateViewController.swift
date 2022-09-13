//
//  ProjectUpdateViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/12.
//

import UIKit

final class ProjectUpdateViewController: UIViewController {
    private let projectCreateView = ProjectUpdateView()
    var item: ProjectDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(projectCreateView)
        view.backgroundColor = .systemBackground
        
        configureNavigationItems()
        configureViewLayout()
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
    
    @objc private func rightBarButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc private func leftBarButtonDidTap() {
        dismiss(animated: true)
    }
    
    private func configureViewLayout() {
        NSLayoutConstraint.activate(
            [
                projectCreateView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                projectCreateView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                projectCreateView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                projectCreateView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
