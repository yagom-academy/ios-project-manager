//
//  MainViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private let toDoViewController = ProjectListViewController(state: .todo)
    private let doingViewController = ProjectListViewController(state: .doing)
    private let doneViewController = ProjectListViewController(state: .done)
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: MainViewModelProtocol
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
        configureLayout()
        configureProjectListActionDelegate()
        viewModel.closure = { [weak self] models in
            self?.toDoViewController.updateList(with: models)
        }
    }
}

// MARK: Action Method
extension MainViewController {
    private func tapAddButton(_ sender: UIAction) {
        let editorViewController = AddViewController()
        editorViewController.modalPresentationStyle = .pageSheet
        let navigationController = UINavigationController(rootViewController: editorViewController)
        present(navigationController, animated: true)
    }
}

// MARK: ProjectListAction Delegate
extension MainViewController: ProjectListActionDelegate {
    private func configureProjectListActionDelegate() {
        [toDoViewController, doingViewController, doneViewController].forEach {
            $0.delegate = self
        }
    }
    
    func deleteProject(willDelete project: Project) {
        viewModel.deleteProject(with: project)
    }
    
    func editProject(willEdit project: Project) {
        let editViewModel = EditViewModel()
        let editViewController = EditViewController(viewModel: editViewModel)
        editViewController.modalPresentationStyle = .pageSheet
        let navigationController = UINavigationController(rootViewController: editViewController)
        present(navigationController, animated: true)
    }
}

// MARK: UI Configuration
extension MainViewController {
    private func configureNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction(handler: tapAddButton)
        )
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray6
        
        [toDoViewController, doingViewController, doneViewController].forEach {
            addChild($0)
            totalStackView.addArrangedSubview($0.view)
        }
        
        view.addSubview(totalStackView)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            totalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            totalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
