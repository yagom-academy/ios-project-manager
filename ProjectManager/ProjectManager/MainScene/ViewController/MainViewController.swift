//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    private let todoViewController = ListViewController(taskState: .todo)
    private let doingViewController = ListViewController(taskState: .doing)
    private let doneViewController = ListViewController(taskState: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationViewUI()
        configureViewUI()
        configureChildViewControllerUI()
        
        var tasks1 = [Task(title: "abc", description: "abc", date: Date()),
                     Task(title: "abdcc", description: "abasfac", date: Date()),
                     Task(title: "absdfc", description: "aasasfbc", date: Date())]
        
        children.forEach { vc in
            guard let vc = vc as? ListViewController else { return }
            vc.applySnapshot(by: tasks1)
        }
    }
}

extension MainViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    private func configureViewUI() {
        self.view.backgroundColor = .systemGray5
    }
    
    private func configureChildViewControllerUI() {
        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)
        
        let stackView = UIStackView()
        
        children.forEach { childViewController in
            stackView.addArrangedSubview(childViewController.view)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
