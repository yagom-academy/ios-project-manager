//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

class MainViewController: UIViewController {
    private let todoViewController = TaskListViewController()
    private let doingViewController = TaskListViewController()
    private let doneViewController = TaskListViewController()
    
    private let mainStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray2
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemGray5
        
        addChildViews()
        addSubViews()
        setupMainStackViewConstraints()
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
            mainStackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
}
