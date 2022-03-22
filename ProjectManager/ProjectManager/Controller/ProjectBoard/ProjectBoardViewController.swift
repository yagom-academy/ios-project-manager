//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

// MARK: - ProjectBoardViewController
final class ProjectBoardViewController: UIViewController {
    
    // MARK: - Property
    private let projectManager = ProjectManager()
    private let todoViewController = ProjectListViewController(status: .todo)
    private let doingViewController = ProjectListViewController(status: .doing)
    private let doneViewController = ProjectListViewController(status: .done)
    
    // MARK: - UI Property
    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    private lazy var tableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoViewController.view,
                                                       doingViewController.view,
                                                       doneViewController.view])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 7
        return stackView
    }()

    // MARK: - View Life Cycle
    override func loadView() {
        self.configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureProjectViewControllerDelegate()
        self.configureSubviews()
        self.navigationBar.delegate = self
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
        self.configureTableStackViewLayout()
    }
     
    // MARK: - Configure View
    private func configureView() {
        self.view = .init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemGray6
    }
    
    private func configureSubviews() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableStackView)
    }
    
    private func configureNavigationItem() {
        let navigationItem = UINavigationItem(title: ProjectBoardScene.mainTitle.rawValue)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(presentProjectCreatorViewController))
        navigationItem.rightBarButtonItem = addButton
        
        navigationBar.items = [navigationItem]
    }
    
    private func configureNavigationBarLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configureTableStackViewLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            tableStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40)
        ])
    }
    
    // MARK: - Configure Controller
    private func configureProjectViewControllerDelegate() {
        self.todoViewController.delegate = self
        self.doingViewController.delegate = self
        self.doneViewController.delegate = self
    }
    
    // MARK: - @objc Method
    @objc func presentProjectCreatorViewController() {
        let creatorViewController = ProjectViewController(mode: .creation,
                                                          project: nil,
                                                          projectCreationDelegate: self,
                                                          projectEditDelegate: nil)
        creatorViewController.modalPresentationStyle = .formSheet
        present(creatorViewController, animated: false, completion: nil)
    }
}

// MARK: - UINavigationBarDelegate
extension ProjectBoardViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}

// MARK: - ProjectCreationViewControllerDelegate
extension ProjectBoardViewController: ProjectCreationDelegate {
    
    func createProject(with content: [String : Any]) {
        self.projectManager.create(with: content)
        self.todoViewController.updateView()
    }

}

// MARK: - ProjectListViewControllerDelegate
extension ProjectBoardViewController: ProjectListViewControllerDelegate {
    
    func readProject(of status: Status, completion: @escaping (Result<[Project]?, Error>) -> Void) {
        self.projectManager.readProject(of: status, completion: completion)
    }
    
    func updateProjectStatus(of identifier: String, with status: Status) {
        self.projectManager.updateProjectStatus(of: identifier, with: status)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func updateProject(of identifier: String, with content: [String : Any]) {
        self.projectManager.updateProjectContent(of: identifier, with: content)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func deleteProject(of identifier: String) {
        self.projectManager.delete(of: identifier)
    }
}
