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
    
    private let projectTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    init(state: State) {
         self.state = state
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
        var longPress = UILongPressGestureRecognizer(target: self, action: #selector(showActionSheet))
        
        view.addGestureRecognizer(longPress)
    }
    
    private func longPressGesture(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self.projectTableView)
        if let indexPath = self.projectTableView.indexPathForRow(at: point) {
            if let cell = self.projectTableView.cellForRow(at: indexPath) {
                
            }
        }
    }
    
    @objc
    func showActionSheet() {
        let alert = UIAlertController(title: "알림", message: "프로젝트 이동", preferredStyle: .actionSheet)
        let moveToTodo = UIAlertAction(title: "TODO로 이동", style: .default)
        let moveToDoing = UIAlertAction(title: "DOING으로 이동", style: .default)
        let moveToDone = UIAlertAction(title: "DONE으로 이동", style: .default)
        alert.addAction(moveToTodo)
        alert.addAction(moveToDoing)
        alert.addAction(moveToDone)
        
        if UIDevice.current.userInterfaceIdiom == .pad { //디바이스 타입이 iPad일때
          if let popoverController = alert.popoverPresentationController {
              // ActionSheet가 표현되는 위치를 저장해줍니다.
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
        switch state {
        case .todo:
            return listViewModel.countProject(in: .todo)
        case .doing:
            return listViewModel.countProject(in: .doing)
        case .done:
            return listViewModel.countProject(in: .done)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else { return TableViewCell() }

        switch state {
        case .todo:
            let project = listViewModel.fetchProject(with: .todo, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            
            return cell
        case .doing:
            let project = listViewModel.fetchProject(with: .doing, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            return cell
        case .done:
            let project = listViewModel.fetchProject(with: .done, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            
            return cell
        }
    }
}

extension CustomTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader else { return CustomTableViewHeader() }
        let count = listViewModel.countProject(in: state)

        switch state {
        case .todo:
            header.configureContent(state: .todo, count: count)
            
            return header
        case .doing:
            header.configureContent(state: .doing, count: count)
            
            return header
        case .done:
            header.configureContent(state: .done, count: count)
            
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var project: ProjectModel
        
        switch state {
        case .todo:
            project = listViewModel.fetchProject(with: .todo, index: indexPath.row)
        case .doing:
            project = listViewModel.fetchProject(with: .doing, index: indexPath.row)
        case .done:
            project = listViewModel.fetchProject(with: .done, index: indexPath.row)
        }
        
        let detailProjectViewController = DetailProjectViewController(isNewProject: false)
        let navigationController = UINavigationController(rootViewController: MainViewController())
        navigationController.pushViewController(detailProjectViewController, animated: true)
//        navigationController.present(detailProjectViewController, animated: true)
        listViewModel.configureProject(in: detailProjectViewController, with: project)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: NameSpace.delete) { action, view, completionHandler in
            switch self.state {
            case .todo:
                self.listViewModel.deleteProject(in: .todo, at: indexPath.row)
            case .doing:
                self.listViewModel.deleteProject(in: .doing, at: indexPath.row)
            case .done:
                self.listViewModel.deleteProject(in: .done, at: indexPath.row)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

private enum NameSpace {
    static let delete = "Delete"
}

