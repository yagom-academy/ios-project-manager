//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

class MainViewController: UIViewController {
    private let todoViewController = TaskListViewController(state: .todo)
    private let doingViewController = TaskListViewController(state: .doing)
    private let doneViewController = TaskListViewController(state: .done)
    
    private let mainStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemGray5
        
        setupNavigationBar()
        addChildViews()
        addSubViews()
        setupMainStackViewConstraints()
    }
    
    private func setupNavigationBar() {
        let plusBarbutton = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(addTask))
        
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = plusBarbutton
    }
    
    @objc private func addTask() {
        let addTastViewController = TaskFormViewController()
        let navigationController = UINavigationController(rootViewController: addTastViewController)
        
        present(navigationController, animated: true)
    }
    
    private func addChildViews() {
        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)
    }
    
    private func addSubViews() {
        mainStackView.addArrangedSubview(todoViewController.view)
        mainStackView.addArrangedSubview(doingViewController.view)
        mainStackView.addArrangedSubview(doneViewController.view)
    }
    
    private func setupMainStackViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safe.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -safe.layoutFrame.height * 0.05)
        ])
    }
}
