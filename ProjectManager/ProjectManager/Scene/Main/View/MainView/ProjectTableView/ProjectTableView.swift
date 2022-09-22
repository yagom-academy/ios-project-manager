//
//  ProjectTableView.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

import UIKit

class ProjectTableView: UITableView {
    
    // MARK: - Properties
    
    var presetDelegate: Presentable?
        
    private let projectType: ProjectType
    
    private var projectHeaderView: ProjectTableHeaderView
    
    private var selectedIndex: Int?

    private let projectTableViewModel = ProjectTableViewModel()

    // MARK: Initializers
    
    init(for projectType: ProjectType) {
        self.projectType = projectType
        projectHeaderView = ProjectTableHeaderView(with: projectType)
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        projectType = .todo
        projectHeaderView = ProjectTableHeaderView(with: .todo)
        super.init(coder: coder)
    }
    
    private func commonInit() {
        tableHeaderView = projectHeaderView
        backgroundColor = .systemGray5
        register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        layoutIfNeeded()
        setupIndexLabel()
        setupDelegates()
        setupGesture()
        separatorStyle = .none
    }
    
    // MARK: - Functions
    
    func getTitle() -> String {
        
        return projectType.titleLabel
    }
    
    func setupIndexLabel() {
        switch projectType {
        case .todo:
            projectHeaderView.setupIndexLabel(with: projectTableViewModel.count(of: .todo))
        case .doing:
            projectHeaderView.setupIndexLabel(with: projectTableViewModel.count(of: .doing))
        case .done:
            projectHeaderView.setupIndexLabel(with: projectTableViewModel.count(of: .done))
        }
    }
    
    private func setupDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func setupGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(didCellTappedLong(_:)))
        addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: - objc Functions
    
    @objc private func didCellTappedLong(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        let touchPoint = gestureRecognizer.location(in: self)
        
        guard let indexPath = indexPathForRow(at: touchPoint) else { return }
        
        let alertController = AlertViewController(with: projectType,
                                              by: indexPath,
                                              tableView: self)
        guard let popoverController = alertController.popoverPresentationController else { return }
        
        let cell = cellForRow(at: indexPath)
        
        popoverController.sourceView = cell
        popoverController.sourceRect = cell?.bounds ?? Design.defaultRect
        
        presetDelegate?.presentAlert(alertController)
    }
    
    // MARK: - Name Space
    
    private enum Design {
        static let longTapDuration: TimeInterval = 1.5
        static let todoAlertActionTitle = "Move to TODO"
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
        static let defaultRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        static let deleteActionTitle = "Delete"
    }
}

extension ProjectTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return projectTableViewModel.count(of: projectType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier,
                                                       for: indexPath) as? ProjectTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(data: projectTableViewModel.searchContent(from: indexPath.row, of: projectType), type: projectType)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        selectedIndex = indexPath.row

        let toDoListDetailViewController = ProjectDetailViewController(with: tableView)
        let navigationController = UINavigationController(rootViewController: toDoListDetailViewController)
        
        toDoListDetailViewController.modalPresentationStyle = .formSheet
        
        toDoListDetailViewController.loadData(of: projectTableViewModel.searchContent(from: indexPath.row,
                                                                              of: projectType))
        toDoListDetailViewController.delegate = self

        presetDelegate?.presentDetail(navigationController)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: Design.deleteActionTitle) { [weak self] _, _, _ in
            self?.projectTableViewModel.delete(from: indexPath.row, of: self?.projectType ?? .todo)
        }
        
        deleteAction.backgroundColor = .red
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
    }
}

extension ProjectTableView: DataSenable {
    func sendData(of item: ToDoItem) {
        projectTableViewModel.update(item: item, from: selectedIndex ?? 0, of: projectType)
    }
}
