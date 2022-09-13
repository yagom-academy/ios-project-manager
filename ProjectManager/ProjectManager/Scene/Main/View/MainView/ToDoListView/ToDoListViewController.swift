//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mockToDoItemManger = MockToDoItemManager()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Design.verticalStackViewSpacing
        
        return stackView
    }()
    
    private let horizontalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = Design.titleLabelText
        uiLabel.font = .preferredFont(forTextStyle: .title1)
        
        return uiLabel
    }()
    
    private let indexLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.textAlignment = .center
        uiLabel.textColor = .white
        uiLabel.font = .preferredFont(forTextStyle: .title3)
        uiLabel.backgroundColor = .black
        
        return uiLabel
    }()
    
    private let todoItemTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        setupSubviews()
        setupListTableViewLayout()
        setupDelegates()
        setupIndexLabel()
        setupLongTapGesture()
        mockToDoItemManger.loadData()
        updateIndexLabelData()
    }
    
    private func setupSubviews() {
        view.addSubview(verticalStackView)
        
        [titleLabel, indexLabel]
            .forEach { horizontalView.addSubview($0) }
        
        [horizontalView, todoItemTableView]
            .forEach { verticalStackView.addArrangedSubview($0) }
    }
    
    private func setupListTableViewLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: horizontalView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            indexLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            indexLabel.widthAnchor.constraint(equalTo: indexLabel.heightAnchor)
        ])
    }
    
    private func setupDelegates() {
        todoItemTableView.delegate = self
        todoItemTableView.dataSource = self
    }
    
    private func setupIndexLabel() {
        indexLabel.layoutIfNeeded()
        indexLabel.drawCircle()
    }
    
    private func setupLongTapGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(didcellTappedLong))
        longTap.minimumPressDuration = Design.longTapDuration
        
        todoItemTableView.addGestureRecognizer(longTap)
    }
    
    private func updateIndexLabelData() {
        indexLabel.text = mockToDoItemManger.count().description
    }
    
    // MARK: - objc Functions
    
    @objc private func didcellTappedLong(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let alertController = UIAlertController()
        
        let doingAlertAction = UIAlertAction(title: Design.doingAlertActionTitle, style: .default) { _ in

        }
        let doneAlertAction = UIAlertAction(title: Design.doneAlertActionTitle, style: .default) { _ in
            
        }
        
        alertController.addAction(doingAlertAction)
        alertController.addAction(doneAlertAction)
        
        let touchPoint = gestureRecognizer.location(in: todoItemTableView)
        
        guard let indexPath = todoItemTableView.indexPathForRow(at: touchPoint),
              let popoverController = alertController.popoverPresentationController
        else { return }
        
        let cell = todoItemTableView.cellForRow(at: indexPath)
        
        popoverController.sourceView = cell
        popoverController.sourceRect = cell?.bounds ?? Design.defaultRect
        
        parent?.present(alertController, animated: true)
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let verticalStackViewSpacing: CGFloat = 2
        static let titleLabelText = "TODO"
        static let longTapDuration: TimeInterval = 1.5
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
        static let defaultRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        static let deleteActionTitle = "삭제"
    }
}

// MARK: - Extentions

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockToDoItemManger.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier, for: indexPath) as? ToDoListTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(data: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toDoListDetailViewController = ToDoListDetailViewController()
        let navigationController = UINavigationController(rootViewController: toDoListDetailViewController)
        
        toDoListDetailViewController.modalPresentationStyle = .formSheet
        toDoListDetailViewController.loadData(of: mockToDoItemManger.content(index: indexPath.row) ?? ToDoItem())

        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: Design.deleteActionTitle) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
       
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
