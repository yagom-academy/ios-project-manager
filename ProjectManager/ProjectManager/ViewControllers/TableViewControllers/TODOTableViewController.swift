//
//  TODOTableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class TODOTableViewController: UITableViewController {
    
    private var selectIndexPath: IndexPath = []
    var headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ScheduleCell.classForCoder(), forCellReuseIdentifier: "scheduleCell")
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView.header
        tableView.backgroundColor = .systemGray6

        tableView.isUserInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.delegate = self
        tableView.dataSource = self

        headerView.addSubViews()
        headerView.configureViews(tableView: tableView)
    }
}

extension TODOTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        headerView.countLabel.text = "\(Task.todoList.count)"
        return Task.todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"

        cell.prepareForReuse()
        cell.task = Task.todoList[indexPath.row]
        cell.titleLabel.text = cell.task.title
        cell.descriptionLabel.text = cell.task.myDescription

        let date = Date(timeIntervalSince1970: cell.task.date)
        let dateString = formatter.string(from: date)
        cell.dateLabel.text = dateString
        checkDateForChangeColor(cell: cell)

        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Task.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            headerView.countLabel.text = "\(Task.todoList.count)"
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }

        let task = Task.todoList[sourceIndexPath.row]
        Task.todoList.remove(at: sourceIndexPath.row)
        Task.todoList.insert(task, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = EditViewController()
        let navigationController = UINavigationController(rootViewController: editViewController)

        editViewController.indexPath = indexPath
        editViewController.task = Task.todoList[indexPath.row]
        editViewController.receiveTaskInformation()

        self.present(navigationController, animated: true, completion: nil)
    }
    
    func checkDateForChangeColor(cell: ScheduleCell) {
        let unixCurrentDate = convertDateToDouble(Date())

        if cell.task.date < unixCurrentDate {
            cell.dateLabel.textColor = .red
        }
    }
}

extension TODOTableViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        selectIndexPath = indexPath
        let item = Task.todoList[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)

        return [dragItem]
    }

    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        Task.todoList.remove(at: selectIndexPath.row)

        tableView.beginUpdates()
        tableView.deleteRows(at: [selectIndexPath], with: .none)
        tableView.endUpdates()
    }
}

extension TODOTableViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        coordinator.session.loadObjects(ofClass: Task.self) { items in
            guard let tasks = items as? [Task] else { return }
            tasks[0].status = "TODO"
            Task.todoList.insert(tasks[0], at: destinationIndexPath.row)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.items.count > 1 {
            return UITableViewDropProposal(operation: .cancel, intent: .automatic)
        }

        return UITableViewDropProposal(operation: .move, intent: .automatic)
    }
}
