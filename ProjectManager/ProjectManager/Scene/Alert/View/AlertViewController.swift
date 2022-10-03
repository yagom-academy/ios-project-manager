//
//  AlertViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/17.
//

import UIKit

final class AlertViewController: UIViewController {
    
    // MARK: - Properties

    private let project: ProjectType
    private let index: IndexPath
    private let tableView: ProjectTableView
    private let alertViewModel: AlertViewModel
    
    private let firstAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
    
    private let secondAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)

        return button
    }()
    
    private lazy var todoAlertAction = UIAction(title: Design.todoAlertActionTitle, state: .off) { [weak self] _ in
        
        self?.alertViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .todo)
        self?.dismiss(animated: true)
    }
    
    private lazy var doingAlertAction = UIAction(title: Design.doingAlertActionTitle, state: .off) { [weak self] _ in
        
        self?.alertViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .doing)
        self?.dismiss(animated: true)
    }
    
    private lazy var doneAlertAction = UIAction(title: Design.doneAlertActionTitle, state: .off) { [weak self] _ in
        self?.alertViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .done)
        self?.dismiss(animated: true)
    }

    // MARK: Initializers

    init(with project: ProjectType, by index: IndexPath, tableView: ProjectTableView, viewModel: AlertViewModel) {
        self.project = project
        self.index = index
        self.tableView = tableView
        self.alertViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.project = .todo
        self.index = IndexPath()
        self.tableView = ProjectTableView(for: .todo, to: ProjectTableViewModel(dataManager: FakeToDoItemManager()))
        self.alertViewModel = AlertViewModel(dataManager: FakeToDoItemManager())
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Functions

    private func commonInit() {
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: firstAlertButton.frame.width, height: 100)
        setupActions(with: project)
        [firstAlertButton, secondAlertButton]
            .forEach { view.addSubview($0) }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstAlertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            firstAlertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            firstAlertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            secondAlertButton.topAnchor.constraint(equalTo: firstAlertButton.bottomAnchor, constant: 4),
            secondAlertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            secondAlertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            firstAlertButton.heightAnchor.constraint(equalToConstant: 40),
            secondAlertButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupActions(with projectType: ProjectType) {
        switch projectType {
        case .todo:
            firstAlertButton.setTitle(Design.doingAlertActionTitle, for: .normal)
            firstAlertButton.addAction(doingAlertAction, for: .touchUpInside)
            secondAlertButton.setTitle(Design.doneAlertActionTitle, for: .normal)
            secondAlertButton.addAction(doneAlertAction, for: .touchUpInside)
        case .doing:
            firstAlertButton.setTitle(Design.todoAlertActionTitle, for: .normal)
            firstAlertButton.addAction(todoAlertAction, for: .touchUpInside)
            secondAlertButton.setTitle(Design.doneAlertActionTitle, for: .normal)
            secondAlertButton.addAction(doneAlertAction, for: .touchUpInside)
        case .done:
            firstAlertButton.setTitle(Design.todoAlertActionTitle, for: .normal)
            firstAlertButton.addAction(todoAlertAction, for: .touchUpInside)
            secondAlertButton.setTitle(Design.doingAlertActionTitle, for: .normal)
            secondAlertButton.addAction(doingAlertAction, for: .touchUpInside)
        }
    }
    
    private enum Design {
        static let todoAlertActionTitle = "Move to TODO"
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
    }
}
