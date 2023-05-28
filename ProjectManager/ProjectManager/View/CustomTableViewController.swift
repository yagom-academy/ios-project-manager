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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showActionSheet))
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else { return TableViewCell() }

        let project = listViewModel.fetchProject(with: state, index: indexPath.row)
        listViewModel.configureCell(to: cell, with: project)
      
        return cell
    }
}

extension CustomTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomTableViewHeader.identifier) as? CustomTableViewHeader else { return CustomTableViewHeader() }
        
        let count = listViewModel.countProject(in: state)
        header.configureContent(state: state, count: count)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = listViewModel.fetchProject(with: state, index: indexPath.row)
        let detailProjectViewController = DetailProjectViewController(isNewProject: false)
        
        // 오류... 하 내비게이션 컨트롤러가 다른 뷰컨 인스턴스를 두번이상 호출
        // 아니면 내비게이션이 없음.. 이거 해결하기
//        navigationController.pushViewController(detailProjectViewController, animated: true)
//        navigationController.present(detailProjectViewController, animated: true)
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
}

