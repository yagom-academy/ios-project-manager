//
//  AlertController.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/17.
//

import UIKit

class AlertController: UIAlertController {
    private let project: ProjectType
    private let index: IndexPath
    private let tableView: ProjectTableView
    private let toDoViewModel: ToDoViewModel
    
    private lazy var todoAlertAction = UIAlertAction(title: Design.todoAlertActionTitle, style: .default) { [weak self] _ in
        
        self?.toDoViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .todo)
    }
    
    private lazy var doingAlertAction = UIAlertAction(title: Design.doingAlertActionTitle, style: .default) { [weak self] _ in
        
        self?.toDoViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .doing)
    }
    
    private lazy var doneAlertAction = UIAlertAction(title: Design.doneAlertActionTitle, style: .default) { [weak self] _ in
        self?.toDoViewModel.move(project: self?.project ?? .todo,
                                 in: self?.index ?? IndexPath(),
                                 to: .done)
    }
    
    init(with project: ProjectType, by index: IndexPath, tableView: ProjectTableView, viewModel: ToDoViewModel) {
        self.project = project
        self.index = index
        self.tableView = tableView
        self.toDoViewModel = viewModel
        // super.init(title: nil, message: nil, preferredStyle: .alert)
        super.init(nibName: nil, bundle: nil)
        self.title = nil
        self.message = nil
        
        setupActions(with: project)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActions(with projectType: ProjectType) {
        switch projectType {
        case .todo:
            self.addAction(doingAlertAction)
            self.addAction(doneAlertAction)
        case .doing:
            self.addAction(todoAlertAction)
            self.addAction(doneAlertAction)
        case .done:
            self.addAction(todoAlertAction)
            self.addAction(doingAlertAction)
        }
    }
    
    private enum Design {
        static let todoAlertActionTitle = "Move to TODO"
        static let doingAlertActionTitle = "Move to DOING"
        static let doneAlertActionTitle = "Move to DONE"
    }
}
