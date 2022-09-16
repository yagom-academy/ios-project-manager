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
    
    private let mainViewModel: MainViewModel
    
    private let projectType: ProjectType
    
    private var projectHeaderView: ProjectTableHeaderView
    
    private var selectedIndex: Int?
    
    // MARK: Initializers
    
    init(for projectType: ProjectType, with manager: MainViewModel) {
        self.projectType = projectType
        projectHeaderView = ProjectTableHeaderView(with: projectType)
        mainViewModel = manager
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        projectType = .todo
        projectHeaderView = ProjectTableHeaderView(with: .todo)
        mainViewModel = MainViewModel()
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
    }
    
    // MARK: - Functions
    
    func getTitle() -> String {
        return projectType.titleLabel
    }
    
    func setupIndexLabel() {
        switch projectType {
        case .todo:
            projectHeaderView.setupIndexLabel(with: mainViewModel.count(of: .todo))
        case .doing:
            projectHeaderView.setupIndexLabel(with: mainViewModel.count(of: .doing))
        case .done:
            projectHeaderView.setupIndexLabel(with: mainViewModel.count(of: .done))
        }
    }
    
    private func setupDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func setupGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(didCellTappedLong(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: - objc Functions
    
    @objc private func didCellTappedLong(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let alertController = UIAlertController()
        
        let touchPoint = gestureRecognizer.location(in: self)
        
        guard let indexPath = self.indexPathForRow(at: touchPoint),
              let popoverController = alertController.popoverPresentationController
        else { return }
        
        let todoAlertAction = UIAlertAction(title: Design.todoAlertActionTitle, style: .default) { [weak self] _ in
            guard let projectType = self?.projectType else { return }
            
            self?.mainViewModel.move(project: projectType, in: indexPath, to: .todo)
        }
        
        let doingAlertAction = UIAlertAction(title: Design.doingAlertActionTitle, style: .default) {  [weak self] _ in
            guard let projectType = self?.projectType else { return }
            
            self?.mainViewModel.move(project: projectType, in: indexPath, to: .doing)
        }
        
        let doneAlertAction = UIAlertAction(title: Design.doneAlertActionTitle, style: .default) { [weak self] _ in
            guard let projectType = self?.projectType else { return }
            
            self?.mainViewModel.move(project: projectType, in: indexPath, to: .done)
        }
        
        switch projectType {
        case .todo:
            alertController.addAction(doingAlertAction)
            alertController.addAction(doneAlertAction)
        case .doing:
            alertController.addAction(todoAlertAction)
            alertController.addAction(doneAlertAction)
        case .done:
            alertController.addAction(todoAlertAction)
            alertController.addAction(doingAlertAction)
        }
        
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
    }
}

extension ProjectTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainViewModel.count(of: projectType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as? ProjectTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(data: mainViewModel.searchContent(from: indexPath.row, of: projectType))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        selectedIndex = indexPath.row

        let toDoListDetailViewController = ProjectDetailViewController(with: tableView)
        let navigationController = UINavigationController(rootViewController: toDoListDetailViewController)
        
        toDoListDetailViewController.modalPresentationStyle = .formSheet
        
        toDoListDetailViewController.loadData(of: mainViewModel.searchContent(from: indexPath.row, of: projectType))
        toDoListDetailViewController.delegate = self

        presetDelegate?.presentDetail(navigationController)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] _, _, _ in
            self?.mainViewModel.delete(from: indexPath.row, of: self?.projectType ?? .todo)
        }
        
        deleteAction.backgroundColor = .red
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
    }
}

extension ProjectTableView: DataSenable {
    func sendData(of item: ToDoItem) {
        mainViewModel.update(item: item, from: selectedIndex ?? 0, of: projectType)
    }
}
