//
//  CreateTodoListViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class CreateTodoListViewController: UIViewController {
    
    private let createTemplateView = FormSheetTemplateView(frame: .zero)
    private var viewModel: TodoListViewModel?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
    }
    
    // MARK: - Methods
    static func create(with viewModel: TodoListViewModel) -> CreateTodoListViewController {
        let viewController = CreateTodoListViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func setupInitialView() {
        createTemplateView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(createTemplateView)
        NSLayoutConstraint.activate([
            createTemplateView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            createTemplateView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            createTemplateView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            createTemplateView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonDidTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )
    }
    
    private func retrieveFormSheetData() -> TodoModel? {
        return createTemplateView.generateTodoModel()
    }
    
    @objc func cancelButtonDidTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func doneButtonDidTapped() {
        guard let data = retrieveFormSheetData() else { return }
        viewModel?.create(with: data)
        self.dismiss(animated: true)
    }
}
