//
//  ProjectManager - MoveToViewController.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class MoveToViewController: UIViewController {
    private var projects = Projects.shared
    var projectManagerViewController: ProjectManagerViewController?
    let project: Project?
    lazy var status = project?.status
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let moveToTodoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to TODO", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(moveToTodo), for: .touchUpInside)
        
        return button
    }()
    
    private let moveToDoingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to DOING", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(moveToDoing), for: .touchUpInside)
        
        return button
    }()
    
    private let moveToDoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Move to DONE", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(moveToDone), for: .touchUpInside)
        
        return button
    }()
    
    init(projectManagerViewController: ProjectManagerViewController? = nil, project: Project) {
        self.projectManagerViewController = projectManagerViewController
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        guard let status else { return }
        configureContentStackView(status: status)
        configureConstraint()
    }
    
    @objc
    private func moveToTodo() {
        guard let project else { return }
        
        for index in 0...projects.list.count-1 {
            if projects.list[index].id == project.id {
                projects.list[index].status = .todo
            }
        }
        
        projectManagerViewController?.projectManagerCollectionView.reloadData()
        self.dismiss(animated: false)
    }
    
    @objc
    private func moveToDoing() {
        guard let project else { return }
        
        for index in 0...projects.list.count-1 {
            if projects.list[index].id == project.id {
                projects.list[index].status = .doing
            }
        }
        
        projectManagerViewController?.projectManagerCollectionView.reloadData()
        self.dismiss(animated: false)
    }
    
    @objc
    private func moveToDone() {
        guard let project else { return }
        
        for index in 0...projects.list.count-1 {
            if projects.list[index].id == project.id {
                projects.list[index].status = .done
            }
        }
        
        projectManagerViewController?.projectManagerCollectionView.reloadData()
        self.dismiss(animated: false)
    }
    
    private func configureContentStackView(status: Status) {
        view.addSubview(contentStackView)
        
        switch status {
        case .todo:
            contentStackView.addArrangedSubview(moveToDoingButton)
            contentStackView.addArrangedSubview(moveToDoneButton)
        case .doing:
            contentStackView.addArrangedSubview(moveToTodoButton)
            contentStackView.addArrangedSubview(moveToDoneButton)
        case .done:
            contentStackView.addArrangedSubview(moveToTodoButton)
            contentStackView.addArrangedSubview(moveToDoingButton)
        }
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
