//
//  ProjectManager - ToDoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
//  Last modified by Max.

import UIKit

final class ToDoListBaseViewController: UIViewController {
    private let viewModel: ToDoBaseViewModelType
    
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
    
    init(_ viewModel: ToDoBaseViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let childViewModel = viewModel.inputs.addChild(status)
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
        let addToDo = UIAction(image: UIImage(systemName: "plus")) { [weak self] _ in
#if DEBUG
            let testValue: [KeywordArgument] = [
                KeywordArgument(key: "id", value: UUID()),
                KeywordArgument(key: "title", value: "추가 테스트"),
                KeywordArgument(key: "body", value: "테스트용입니다"),
                KeywordArgument(key: "dueDate", value: Date()),
                KeywordArgument(key: "modifiedAt", value: Date()),
                KeywordArgument(key: "status", value: ToDoStatus.toDo.rawValue)
            ]
            self?.viewModel.inputs.createData(values: testValue)
#endif
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(primaryAction: addToDo)
    }
    
    private func setupBinding() {
        viewModel.outputs.error.bind { [weak self] error in
            guard let self,
                  let error else { return }
            let alertBuilder = AlertBuilder(prefferedStyle: .alert)
                .setTitle(error.alertTitle)
                .setMessage(error.alertMessage)
                .addAction(.confirm)
                .build()
            present(alertBuilder, animated: true)
        }
    }
}

