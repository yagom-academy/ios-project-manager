//
//  ProjectManager - ToDoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
//  Last modified by Max.

import UIKit

class ToDoListBaseViewController: UIViewController {
    private let viewModel: ToDoListBaseViewModel
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        stackView.spacing = 10
        return stackView
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    init(_ viewModel: ToDoListBaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addChildren()
        setupUI()
        setupNavigationBar()
        setupBinding()
    }
    
    private func addChildren() {
        ToDoStatus.allCases.forEach { status in
            let childViewModel = viewModel.addChildModel(status: status)
            let childViewController = ToDoListChildViewController(status,
                                                              viewModel: childViewModel,
                                                              dateFormatter: dateFormatter)
            self.addChild(childViewController)
            stackView.addArrangedSubview(childViewController.view)
            
            NSLayoutConstraint.activate([
                childViewController.view.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                childViewController.view.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
            ])
        }
    }
    
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground
        stackView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.title = "Project Manager"
        let addToDo = UIAction(image: UIImage(systemName: "plus")) { _ in }
        navigationItem.rightBarButtonItem = UIBarButtonItem(primaryAction: addToDo)
    }
    
    private func readData() {
        viewModel.fetchData()
    }
    
    private func setupBinding() {
        viewModel.error.bind { [weak self] _ in
            guard let self,
                  let error = viewModel.error.value else { return }
            let alertBuilder = AlertBuilder(viewController: self, prefferedStyle: .alert)
            alertBuilder.setControllerTitle(title: error.alertTitle)
            alertBuilder.setControllerMessage(message: error.alertMessage)
            alertBuilder.addAction(.confirm)
            let alertController = alertBuilder.makeAlertController()
            present(alertController, animated: true)
        }
    }
}

