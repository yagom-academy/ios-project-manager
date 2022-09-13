//
//  ProjectUpdateViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/12.
//

import UIKit

final class ProjectUpdateViewController: UIViewController {
    private let projectUpdateView = ProjectUpdateView()
    var item: ProjectDTO?
    weak var delegate: ProjectManagerDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(projectUpdateView)
        view.backgroundColor = .systemBackground
        
        configureNavigationItems()
        configureViewLayout()
        configureViewItems()
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
        if item == nil {
            let newItem = projectUpdateView.makeItems()
            
            let data = ProjectDTO(id: UUID().description,
                                  title: newItem.textArray[0],
                                  body: newItem.textArray[1],
                                  date: newItem.date,
                                  workState: .todo)
            
            delegate?.create(data: data)
        }
        
        dismiss(animated: true)
    }
    
    @objc private func leftBarButtonDidTap() {
        if let item = self.item {
            let newItem = projectUpdateView.makeItems()
            
            let data = ProjectDTO(id: item.id,
                                  title: newItem.textArray[0],
                                  body: newItem.textArray[1],
                                  date: newItem.date,
                                  workState: item.workState)
            
            delegate?.update(id: item.id, data: data)
        }
        
        dismiss(animated: true)
    }
    
    private func configureViewItems() {
        guard let item = item else { return }
        
        projectUpdateView.configureItem(title: item.title, body: item.body)
    }
    
    private func configureViewLayout() {
        NSLayoutConstraint.activate(
            [
                projectUpdateView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                projectUpdateView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                projectUpdateView.leadingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                projectUpdateView.trailingAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
        )
    }
}
