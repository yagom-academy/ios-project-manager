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
    private let doingViewController = DoingProjectTableViewController()
    private let doneViewController = DoneProjectTableViewController()
    
    // MARK: - UI Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoViewController.view,
                                                       doingViewController.view,
                                                       doneViewController.view])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
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
        self.configureDelegate()
        self.configureStackViewLayout()
    }
     
    // MARK: - Configure UI
    private func configureView() {
        self.view = .init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemGray3
    }
    
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: "Project Manager")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(presentProjectCreatorViewController))
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
    
    private func configureStackViewLayout() {
        self.view.addSubview(stackView)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    // MARK: - Configure Controller
    private func configureDelegate() {
        self.todoViewController.delegate = self
        self.doingViewController.delegate = self
        self.doneViewController.delegate = self
    }
    
    // MARK: - @objc Method
    @objc func presentProjectCreatorViewController() {
        let creatorViewController = ProjectCreatorViewController()
        creatorViewController.modalPresentationStyle = .formSheet
        creatorViewController.delegate = self
        present(creatorViewController, animated: false, completion: nil)
    }
}

// MARK: - UINavigationBarDelegate
extension ProjectBoardViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

// MARK: - ProjectDetailViewControllerDelegate
extension ProjectBoardViewController: ProjectCreatorViewControllerDelegate {
 
    func createProject(with content: [String: Any]) {
        self.projectManager.create(with: content)
        todoViewController.applySnapshot()
    }
}

// MARK: - ProjectTableViewControllerDelegate
extension ProjectBoardViewController: ProjectTableViewControllerDelegate {
    func readProject(of status: Status) -> [Project]? {
        return projectManager.readProject(of: status)
    }
    
    func updateProjectStatus(of identifier: UUID, with status: Status) {
        self.projectManager.updateProjectStatus(of: identifier, with: status)
        self.todoViewController.applySnapshot()
        self.doingViewController.applySnapshot()
        self.doneViewController.applySnapshot()
    }
    
    func updateProject(of identifier: UUID, with content: [String : Any]) {
        self.projectManager.updateProject(of: identifier, with: content)
        self.todoViewController.applySnapshot()
        self.doingViewController.applySnapshot()
        self.doneViewController.applySnapshot()
    }
    
    func deleteProject(of identifier: UUID) {
        self.projectManager.delete(of: identifier)
    }
}
