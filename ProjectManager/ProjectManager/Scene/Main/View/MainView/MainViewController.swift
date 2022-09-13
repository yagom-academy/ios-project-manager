//
//  ProjectManager - ViewController.swift
//  Created by brad, bard.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties

    private let toDoListTableViewController = ToDoListViewController()
    private let doingListTableViewController = DoingListViewController()
    private let doneListTableViewController = DoneListViewController()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Design.horizontalStackViewSpacing
        stackView.backgroundColor = .systemGray3

        return stackView
    }()
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        setupSubviews()
        setupVerticalStackViewLayout()
        setupView()
    }
    
    private func setupSubviews() {
        view.addSubview(horizontalStackView)
        
        [toDoListTableViewController, doingListTableViewController, doneListTableViewController]
            .forEach { addChild($0) }
        
        [toDoListTableViewController.view, doingListTableViewController.view, doneListTableViewController.view]
            .forEach { horizontalStackView.addArrangedSubview($0) }
    }
    
    private func setupVerticalStackViewLayout() {
        guard let navigationBarHeight = navigationController?.navigationBar.frame.height
        else { return }
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -navigationBarHeight),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9490192533, green: 0.9490200877, blue: 0.9662286639, alpha: 1)
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.title = Design.navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: Design.navigationTitleFontSize, weight: .bold)
        ]
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: Design.plusImage),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didPlusButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func didPlusButtonTapped() {
        let registrationViewController = RegistrationViewController()
        let navigationController = UINavigationController(rootViewController: registrationViewController)
        registrationViewController.modalPresentationStyle = .formSheet
        
        present(navigationController, animated: true)
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let horizontalStackViewSpacing: CGFloat = 8
        static let navigationTitle = "Project Manager"
        static let navigationTitleFontSize: CGFloat = 20
        static let plusImage = "plus"
    }
}
