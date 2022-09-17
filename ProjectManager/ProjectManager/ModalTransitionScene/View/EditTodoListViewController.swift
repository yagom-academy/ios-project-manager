//
//  EditTodoListViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class EditTodoListViewController: UIViewController {
    
    private let editTemplateView = FormSheetTemplateView(frame: .zero)
    private var viewModel: TodoListViewModel
    private var currentTodo: Todo
    
    // MARK: - Initializer
    init(viewModel: TodoListViewModel, category: String, index: Int) {
        self.viewModel = viewModel
        self.currentTodo = viewModel.fetchTodo(in: category, at: index)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupData()
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        editTemplateView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(editTemplateView)
        NSLayoutConstraint.activate([
            editTemplateView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            editTemplateView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            editTemplateView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            editTemplateView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "TODO"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )
    }
    
    private func setupData() {
        editTemplateView.setupData(with: currentTodo)
    }
    
    private func retrieveFormSheetData() -> Todo? {
        return editTemplateView.generateTodoModel(with: currentTodo.category)
    }
    
    // MARK: - @objc Methods
    @objc private func editButtonDidTapped() {
        guard let data = retrieveFormSheetData() else { return }
        viewModel.edit(todo: currentTodo, with: data)
        self.dismiss(animated: true)
    }
    
    @objc private func doneButtonDidTapped() {
        self.dismiss(animated: true)
    }
}
