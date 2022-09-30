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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - Methods
    private func setupInitialView() {
        formSheetView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(formSheetView)
        NSLayoutConstraint.activate([
            formSheetView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 60
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
        switch viewModel.mode {
        case .create:
            setupCreateModeNavigationBar()
        case .edit:
            setupEditModeNavigationBar()
        }
    }
    
    private func setupCreateModeNavigationBar() {
        let navigationBar = UINavigationBar(
            frame: .init(x: 0, y: 0, width: view.frame.width, height: 60)
        )
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground

        let naviItem = UINavigationItem(title: "Todo")
        naviItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissView)
        )
        naviItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonDidTapped)
        )
        navigationBar.items = [naviItem]

        view.addSubview(navigationBar)
    }
    
    private func setupEditModeNavigationBar() {
        let navigationBar = UINavigationBar(
            frame: .init(x: 0, y: 0, width: view.frame.width, height: 60)
        )
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground

        let naviItem = UINavigationItem(title: "Todo")
        naviItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonDidTapped)
        )
        naviItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissView)
        )
        navigationBar.items = [naviItem]

        view.addSubview(navigationBar)
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
