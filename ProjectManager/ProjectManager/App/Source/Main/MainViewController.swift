//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

final class MainViewController: UIViewController {
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
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(addTask))
        
        let leftBarButtonTittle = "History"
        let leftBarButton = UIBarButtonItem(title: leftBarButtonTittle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(showHistory(sender:)))
        
        let projectTitle = "Project Manager"
        
        navigationItem.title = projectTitle
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func addTask() {
        let taskFormViewController = TaskFormViewController()
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        
        present(navigationController, animated: true)
    }
    
    @objc private func showHistory(sender: UIBarButtonItem) {
        let historyViewController = HistoryViewController()
        
        historyViewController.modalPresentationStyle = .popover
        historyViewController.popoverPresentationController?.sourceView = view
        historyViewController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        historyViewController.popoverPresentationController?.permittedArrowDirections = .up
        
        present(historyViewController, animated: true)
    }
    
    private func addChildViews() {
        addChild(todoViewController)
        addChild(doingViewController)
        addChild(doneViewController)
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
