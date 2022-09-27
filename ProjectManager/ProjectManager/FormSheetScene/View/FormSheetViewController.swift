//
//  EditTodoListViewController.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

enum PageMode {
    case create
    case edit
}

final class FormSheetViewController: UIViewController {
    private let formSheetView = FormSheetTemplateView(frame: .zero)
    private var viewModel: FormSheetViewModel
    
    // MARK: - Initializer
    init(viewModel: FormSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewLifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupInitialData()
        setupNavigationBar()
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        formSheetView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(formSheetView)
        NSLayoutConstraint.activate([
            formSheetView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            formSheetView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            formSheetView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            formSheetView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
    
    private func setupInitialData() {
        switch viewModel.mode {
        case .create:
            return
        case .edit:
            formSheetView.setupData(with: viewModel.currentTodo)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Category.todo
        switch viewModel.mode {
        case .create:
            setupCreateModeNavigationBar()
        case .edit:
            setupEditModeNavigationBar()
        }
    }
    
    private func setupCreateModeNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissView)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )
    }
    
    private func setupEditModeNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissView)
        )
    }

    // MARK: - @objc Methods
    @objc private func editButtonDidTapped() {
        guard let data = formSheetView.generateTodoModel(with: viewModel.currentTodo?.category) else { return }
        viewModel.edit(to: data)
        self.dismiss(animated: true)
    }
    
    @objc private func doneButtonDidTapped() {
        guard let data = formSheetView.generateTodoModel(with: Category.todo) else { return }
        viewModel.create(data)
        self.dismiss(animated: true)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
