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
    
    private let stackViewBackgroundView: UIView = {
       let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .systemGray4
        return backgroundView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoViewController.view,
                                                       doingViewController.view,
                                                       doneViewController.view])
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        self.configureSubviews()
        self.navigationBar.delegate = self
        self.configureNavigationItem()
        self.configureNavigationBarLayout()
        self.configureDelegate()
        self.configureStackViewBackgroundViewLayout()
        self.configureStackViewLayout()
    }
     
    // MARK: - Configure View
    private func configureView() {
        self.view = .init()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemGray6
    }
    
    private func configureSubviews() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(stackViewBackgroundView)
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
        let safeArea = self.view.safeAreaLayoutGuide
        navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    private func configureStackViewBackgroundViewLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackViewBackgroundView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            stackViewBackgroundView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            stackViewBackgroundView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            stackViewBackgroundView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -40)
        ])
    }
    
    private func configureStackViewLayout() {
        self.stackViewBackgroundView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stackViewBackgroundView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: stackViewBackgroundView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: stackViewBackgroundView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: stackViewBackgroundView.bottomAnchor)
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
        todoViewController.updateView()
    }
}

// MARK: - ProjectTableViewControllerDelegate
extension ProjectBoardViewController: ProjectTableViewControllerDelegate {
    func readProject(of status: Status) -> [Project]? {
        return projectManager.readProject(of: status)
    }
    
    func updateProjectStatus(of identifier: UUID, with status: Status) {
        self.projectManager.updateProjectStatus(of: identifier, with: status)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func updateProject(of identifier: UUID, with content: [String : Any]) {
        self.projectManager.updateProject(of: identifier, with: content)
        self.todoViewController.updateView()
        self.doingViewController.updateView()
        self.doneViewController.updateView()
    }
    
    func deleteProject(of identifier: UUID) {
        self.projectManager.delete(of: identifier)
    }
}
