//
//  EditTodoListViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class EditTodoListViewController: UIViewController {
    
    private let editTemplateView = FormSheetTemplateView(frame: .zero)
    private var viewModel: TodoListViewModel?
    private var cellData: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
    }
    
    static func create(with viewModel: TodoListViewModel,
                       cellData: TodoModel) -> EditTodoListViewController {
        let viewController = EditTodoListViewController()
        viewController.viewModel = viewModel
        viewController.cellData = cellData
        return viewController
    }
    
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
        editTemplateView.setupData(with: cellData)
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
    
    private func retrieveFormSheetData() -> TodoModel? {
        return editTemplateView.generateTodoModel()
    }
    
    @objc private func editButtonDidTapped() {
        guard let data = retrieveFormSheetData(),
              let cellData = cellData else { return }
        viewModel?.update(model: cellData, to: data)
        self.dismiss(animated: true)
    }
    
    @objc private func doneButtonDidTapped() {
        self.dismiss(animated: true)
    }
}
