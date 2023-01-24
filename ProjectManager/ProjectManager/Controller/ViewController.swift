//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var todoHeaderView: CustomTableHeader!
    @IBOutlet weak var doingHeaderView: CustomTableHeader!
    @IBOutlet weak var doneHeaderView: CustomTableHeader!
    
    let dataSourceVM = DataSourceViewModel()
    let taskListVM = TaskListViewModel()
    
    private lazy var todoDataSource = makeDataSource(tableView: todoTableView, taskListVM.todoTasks)
    private lazy var doingDataSource = makeDataSource(tableView: doingTableView, taskListVM.doingTasks)
    private lazy var doneDataSource = makeDataSource(tableView: doneTableView, taskListVM.doneTasks)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperViewColor()
        todoTableView.dataSource = todoDataSource
        doingTableView.dataSource = doingDataSource
        doneTableView.dataSource = doneDataSource
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        reloadTasksTableViewDataSource()
    }
    
    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        let addViewController = storyboard?.instantiateViewController(identifier: "addViewController") as? AddViewController ?? AddViewController()
        addViewController.setUpTaskListVM(taskListVM)
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }
    
    private func reloadTasksTableViewDataSource() {
        taskListVM.reloadTodoTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.todoHeaderView.setTaskCountLabel(self.taskListVM, status: .todo)
            self.update(dataSource: self.todoDataSource, tasksStatus: tasks)
        }
        taskListVM.reloadDoingTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.doingHeaderView.setTaskCountLabel(self.taskListVM, status: .doing)
            self.update(dataSource: self.doingDataSource, tasksStatus: tasks)
        }
        taskListVM.reloadDoneTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.doneHeaderView.setTaskCountLabel(self.taskListVM, status: .done)
            self.update(dataSource: self.doneDataSource, tasksStatus: tasks)
        }
    }
    
    private func makeDataSource(tableView: UITableView,
                                _ tasks: [Task]) -> UITableViewDiffableDataSource<Section, Task> {
        
        dataSourceVM.registerCell(tableView: tableView)
        
        let dataSource = UITableViewDiffableDataSource<Section, Task>(tableView: tableView) { _, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell",
                                                     for: indexPath) as? TableViewCell ?? TableViewCell()
            cell.configureCell(task: task)
            cell.gestureRecognizerHelperDelegate = self
            return cell
        }
        dataSourceVM.configureSnapShot(dataSource: dataSource, tasks: tasks)
        return dataSource
    }
    
    private func update(dataSource: UITableViewDiffableDataSource<Section, Task>, tasksStatus: [Task]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        snapShot.appendSections([.main])
        snapShot.appendItems(tasksStatus)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func setupSuperViewColor() {
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    }    
}

extension ViewController: GestureRecognizerHelperDelegate {
    func sendLongPressGesture(_ sender: UILongPressGestureRecognizer) {
        guard let tableView = sender.view?.superview as? UITableView,
              let viewPoint = sender.view?.convert(CGPoint.zero, to: tableView),
              let indexPath = tableView.indexPathForRow(at: viewPoint) else { return }
        popOverAlert(tableView: tableView, indexPathRow: indexPath.row, viewPoint: viewPoint)
    }
    
    private func popOverAlert(tableView: UITableView, indexPathRow: Int, viewPoint: CGPoint) {
        let popOverAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        switch tableView {
        case todoTableView:
            makeAction(tasks: taskListVM.todoTasks, status: .doing, indexPathRow: indexPathRow, popOverAlertController)
            makeAction(tasks: taskListVM.todoTasks, status: .done, indexPathRow: indexPathRow, popOverAlertController)
        case doingTableView:
            makeAction(tasks: taskListVM.doingTasks, status: .todo, indexPathRow: indexPathRow, popOverAlertController)
            makeAction(tasks: taskListVM.doingTasks, status: .done, indexPathRow: indexPathRow, popOverAlertController)
        case doneTableView:
            makeAction(tasks: taskListVM.doneTasks, status: .todo, indexPathRow: indexPathRow, popOverAlertController)
            makeAction(tasks: taskListVM.doneTasks, status: .doing, indexPathRow: indexPathRow, popOverAlertController)
        default:
            break
        }
        popOverAlertController.modalPresentationStyle = .popover
        popOverAlertController.popoverPresentationController?.sourceView = tableView
        popOverAlertController.popoverPresentationController?.permittedArrowDirections = [.up]
        popOverAlertController.popoverPresentationController?.sourceRect = CGRect(x: viewPoint.x, y: viewPoint.y, width: 50, height: 50)
        present(popOverAlertController, animated: true)
    }
    
    private func makeAction(tasks: [Task], status: Status, indexPathRow: Int, _ popOvevViewController: UIAlertController) {
        let alertTitle = "Mote to \(status.rawValue)"
        let firstAction = UIAlertAction(title: alertTitle, style: .default) { _ in
            self.taskListVM.moveToStatus(tasks: tasks, indexPathRow: indexPathRow, to: status)
        }
        popOvevViewController.addAction(firstAction)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = storyboard?.instantiateViewController(withIdentifier: "editViewController") as? EditViewController ?? EditViewController()
        sendDelegateInfo(editViewController, tableView, indexPath)
        editViewController.setUpTaskListVM(taskListVM)
        editViewController.modalPresentationStyle = .formSheet
        present(editViewController, animated: true)
    }
    
    private func sendDelegateInfo(_ editViewController: EditViewController,
                                  _ tableView: UITableView,
                                  _ indexPath: IndexPath ) {
        switch tableView {
        case todoTableView:
            let info = DelegateInfo(status: .todo, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        case doingTableView:
            let info = DelegateInfo(status: .doing, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        case doneTableView:
            let info = DelegateInfo(status: .done, indexPathRow: indexPath.row)
            editViewController.setUpDelegateInfo(info: info)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { [weak self] _, _, _ in
            guard let self = self else { return }
            switch tableView {
            case self.todoTableView:
                self.taskListVM.delete(tasks: self.taskListVM.todoTasks, indexPathRow: indexPath.row)
            case self.doingTableView:
                self.taskListVM.delete(tasks: self.taskListVM.doingTasks, indexPathRow: indexPath.row)
            case self.doneTableView:
                self.taskListVM.delete(tasks: self.taskListVM.doneTasks, indexPathRow: indexPath.row)
            default:
                break
            }
        }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
