//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectBoardViewController: UIViewController {
    
    // MARK: - Property
    private let projectManager = ProjectManager()
    private let todoViewController = TodoProjectTableViewController()
    
    // MARK: - UI Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.delegate = self
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
        self.todoViewController.projectManager = projectManager
        self.configurTodoProjectviewControllerLayout()
    }
     
    // MARK: - Configure UI
    private func configureView() {
        self.view = .init()
        self.view.backgroundColor = .systemGray3
    }
    
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: "Project Manager")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(presentProjectDetailViewController))
        navigationItem.rightBarButtonItem = addButton
        
        navigationBar.items = [navigationItem]
    }
    
    private func configureNavigationBarLayout() {
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configurTodoProjectviewControllerLayout() {
        self.view.addSubview(todoViewController.view)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            todoViewController.view.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            todoViewController.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            todoViewController.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            todoViewController.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    // MARK: - @objc Method
    @objc func presentProjectDetailViewController() {
        let detailViewController = ProjectDetailViewController()
        detailViewController.modalPresentationStyle = .formSheet
        detailViewController.delegate = self
        present(detailViewController, animated: false, completion: nil)
    }
}

// MARK: - UINavigationBarDelegate
extension ProjectBoardViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

// MARK: - ProjectDetailViewControllerDelegate
extension ProjectBoardViewController: ProjectDetailViewControllerDelegate {
    func createProject(with content: [String: Any]) {
        self.projectManager.create(with: content)
        todoViewController.applySnapshot()
    }
}
