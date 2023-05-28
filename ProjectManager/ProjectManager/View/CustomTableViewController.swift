//
//  CustomTableViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/23.
//

import UIKit

class CustomTableViewController: UIViewController {
    private let listViewModel = ListViewModel.shared
    let state: State
    let mainViewController: UIViewController
    
    private let projectTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    init(state: State, mainViewController: UIViewController) {
        self.state = state
        self.mainViewController = mainViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        configureTableView()
        configureViewModel()
        configureGesture()
    }
    
    func configureViewModel() {
        switch state {
        case .todo:
            listViewModel.todoList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        case .doing:
            listViewModel.doingList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        case .done:
            listViewModel.doneList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(projectTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            projectTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        projectTableView.delegate = self
        projectTableView.dataSource = self
    }
    
    private func configureGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        projectTableView.addGestureRecognizer(longPress)
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: projectTableView)
            if let indexPath = projectTableView.indexPathForRow(at: touchPoint) {
                showActionSheet(index: indexPath)
            }
        }
    }

    func showActionSheet(index: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let project = listViewModel.fetchProject(with: state, index: index.row)
        let moveToTodo = UIAlertAction(title: NameSpace.moveTodo, style: .default) { _ in
            self.listViewModel.moveProject(project: project, to: .todo, at: index.row)
        }
        
        let moveToDoing = UIAlertAction(title: NameSpace.moveDoing, style: .default) { _ in
            self.listViewModel.moveProject(project: project, to: .doing, at: index.row)
        }
        
        let moveToDone = UIAlertAction(title: NameSpace.moveDone, style: .default) { _ in
            self.listViewModel.moveProject(project: project, to: .done, at: index.row)
        }
        
        switch state {
        case .todo:
            alert.addAction(moveToDoing)
            alert.addAction(moveToDone)
        case .doing:
            alert.addAction(moveToTodo)
            alert.addAction(moveToDone)
        case .done:
            alert.addAction(moveToTodo)
            alert.addAction(moveToDoing)
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
          if let popoverController = alert.popoverPresentationController {
              popoverController.sourceView = self.view
              popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
              popoverController.permittedArrowDirections = []
              self.present(alert, animated: true)
          }
        } else {
          self.present(alert, animated: true)
        }
    }
}

extension CustomTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.countProject(in: state)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier)
                as? TableViewCell else {
            return TableViewCell()
        }

        let project = listViewModel.fetchProject(with: state, index: indexPath.row)
        listViewModel.configureCell(to: cell, with: project)
      
        return cell
    }
}

extension CustomTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier)
                as? CustomTableViewHeader else {
            return CustomTableViewHeader()
        }
        
        let count = listViewModel.countProject(in: state)
        header.configureContent(state: state, count: count)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = listViewModel.fetchProject(with: state, index: indexPath.row)
        let navigationController = mainViewController.navigationController
        let detailProjectViewController = DetailProjectViewController(isNewProject: false)
        detailProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: detailProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
        
        listViewModel.configureProject(in: detailProjectViewController, with: project)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: NameSpace.delete) { action, view, completionHandler in
            self.listViewModel.deleteProject(in: self.state, at: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

private enum NameSpace {
    static let delete = "Delete"
    static let moveTodo = "Move To TODO"
    static let moveDoing = "Move To DOING"
    static let moveDone = "Move To DONE"
}
