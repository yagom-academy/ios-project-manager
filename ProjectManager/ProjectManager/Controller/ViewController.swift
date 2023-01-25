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
    private let dataSourceVM = DataSourceViewModel()
    private let taskListVM = TaskListViewModel()
    private lazy var todoDataSource = makeDataSource(tableView: todoTableView, taskListVM.todoTasks)
    private lazy var doingDataSource = makeDataSource(tableView: doingTableView, taskListVM.doingTasks)
    private lazy var doneDataSource = makeDataSource(tableView: doneTableView, taskListVM.doneTasks)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDefaultHeaderViewLabel()
        setUpSuperViewColor()
        tableViewAttributeDeclaration([todoTableView, doingTableView, doneTableView], [todoDataSource, doingDataSource, doneDataSource])
        reloadTasksTableViewDataSource()
    }
    
    @IBAction func tapAdd(_ sender: UIBarButtonItem) {
        let addViewController = storyboard?.instantiateViewController(identifier: "addViewController") as? AddViewController ?? AddViewController()
        addViewController.setUpTaskListVM(taskListVM)
        addViewController.modalPresentationStyle = .formSheet
        present(addViewController, animated: true)
    }
    
    private func tableViewAttributeDeclaration(_ tableViews: [UITableView], _ dataSources: [UITableViewDiffableDataSource<Section, Task>]) {
        for index in 0..<tableViews.count {
            tableViews[index].delegate = self
            tableViews[index].dataSource = dataSources[index]
        }
    }
    
    private func reloadTasksTableViewDataSource() {
        taskListVM.reloadTodoTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.todoHeaderView.setTaskCountLabel(self.taskListVM, status: .todo)
            self.dataSourceVM.configureSnapShot(dataSource: self.todoDataSource, tasks: tasks)
        }
        taskListVM.reloadDoingTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.doingHeaderView.setTaskCountLabel(self.taskListVM, status: .doing)
            self.dataSourceVM.configureSnapShot(dataSource: self.doingDataSource, tasks: tasks)
        }
        taskListVM.reloadDoneTasks = { [weak self] tasks in
            guard let self = self else { return }
            self.doneHeaderView.setTaskCountLabel(self.taskListVM, status: .done)
            self.dataSourceVM.configureSnapShot(dataSource: self.doneDataSource, tasks: tasks)
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
    
    private func setUpSuperViewColor() {
        view.backgroundColor = Preset.defaultBackground
    }
    
    private func setUpDefaultHeaderViewLabel() {
        todoHeaderView.setTaskCountLabel(taskListVM, status: .todo)
        doingHeaderView.setTaskCountLabel(taskListVM, status: .doing)
        doneHeaderView.setTaskCountLabel(taskListVM, status: .done)
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
        popOverAlertController.popoverPresentationController?.sourceRect = Preset.defaultpopOverArrowPoint(viewPoint)
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
