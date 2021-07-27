//
//  ProjectManager - TaskViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    @IBOutlet weak var doneTableView: UITableView!
    @IBOutlet weak var todoCountLabel: UILabel!
    @IBOutlet weak var doingCountLabel: UILabel!
    @IBOutlet weak var doneCountLabel: UILabel!
    
    private lazy var todoDataSource: TaskDataSource = TaskDataSource(taskType: .todo, tasks: todos)
    private lazy var doingDataSource: TaskDataSource = TaskDataSource(taskType: .doing, tasks: doings)
    private lazy var doneDataSource: TaskDataSource = TaskDataSource(taskType: .done, tasks: dones)
    private let cellNibName = UINib(nibName: TableViewCell.identifier, bundle: nil)
    private var todos = [Task]()
    private var doings = [Task]()
    private var dones = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        for (tableView, label, tasks) in [(todoTableView, todoCountLabel ,todos),
                                          (doingTableView, doingCountLabel ,doings),
                                          (doneTableView, doneCountLabel ,dones)] {
            setTableView(tableView ?? UITableView(), tasks)
            setLabelToCircle(label ?? UILabel(), tasks.count)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangedCountLabel),
                                               name: Notification.Name("changedTasksValue"),
                                               object: nil)
    }
    
    @objc func didChangedCountLabel(_ notification: Notification) {
        guard let dataSource = notification.object as? TaskDataSource else { return }
        
        switch dataSource.taskType {
        case .todo:
            todoCountLabel.text = "\(dataSource.tasks.count)"
        case .doing:
            doingCountLabel.text = "\(dataSource.tasks.count)"
        case .done:
            doneCountLabel.text = "\(dataSource.tasks.count)"
        }
    }
    
    private func setTableView(_ tableView: UITableView, _ tasks: [Task]) {
        tableView.delegate = self
        tableView.dataSource = dataSourceForTableView(tableView)
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    private func dataSourceForTableView(_ tableView: UITableView) -> TaskDataSource {
        if tableView == todoTableView {
            return todoDataSource
        } else if tableView == doingTableView {
            return doingDataSource
        } else {
            return doneDataSource
        }
    }
    
    private func setLabelToCircle(_ label: UILabel, _ countNumber: Int) {
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 0.5 * todoCountLabel.bounds.size.width
        label.text = "\(countNumber)"
    }
    
    private func fetchData() {
        guard let todoData = NSDataAsset(name: "todo"),
              let doingData = NSDataAsset(name: "doing"),
              let doneData = NSDataAsset(name: "done") else { return }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        do {
            todos = try decoder.decode([Task].self, from: todoData.data)
            doings = try decoder.decode([Task].self, from: doingData.data)
            dones = try decoder.decode([Task].self, from: doneData.data)
        } catch {
            print(TaskError.decodingFailure.localizedDescription)
        }
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        guard let taskAlertViewController = self.storyboard?.instantiateViewController(identifier: "TaskAlert") else { return }
        
        taskAlertViewController.modalPresentationStyle = .formSheet
        taskAlertViewController.modalTransitionStyle =  .crossDissolve
        self.present(taskAlertViewController, animated: true, completion: nil)
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 7))

        headerView.backgroundColor = .systemGray6
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
}

extension TaskViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dataSource = dataSourceForTableView(tableView)
        let dragCoordinator = TaskDragCoordinator(sourceIndexPath: indexPath)
        session.localContext = dragCoordinator

        return dataSource.dragItems(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? TaskDragCoordinator,
          dragCoordinator.dragCompleted == true,
          dragCoordinator.isReordering == false
        else { return }
        let dataSource = dataSourceForTableView(tableView)
        let sourceIndexPath = dragCoordinator.sourceIndexPath
        
        tableView.performBatchUpdates {
            dataSource.deleteTask(at: sourceIndexPath.section)
            tableView.deleteSections([sourceIndexPath.section, sourceIndexPath.section], with: .automatic)
        }
    }
    
}

extension TaskViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
      return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let dataSource = dataSourceForTableView(tableView)
        let item = coordinator.items[0]
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        }
     
        switch coordinator.proposal.operation {
        case .move:
            guard let dragCoordinator = coordinator.session.localDragSession?.localContext as? TaskDragCoordinator
            else { return }
            
            if let sourceIndexPath = item.sourceIndexPath {
                dragCoordinator.isReordering = true
                
                tableView.performBatchUpdates {
                    dataSource.moveTask(at: sourceIndexPath.section, to: destinationIndexPath.section)
                    tableView.deleteSections([sourceIndexPath.section, sourceIndexPath.section], with: .automatic)
                    tableView.insertSections([destinationIndexPath.section, destinationIndexPath.section], with: .automatic)
                }
            } else {
                dragCoordinator.isReordering = false
                
                if let taskItem = item.dragItem.localObject as? Task {
                    tableView.performBatchUpdates {
                        dataSource.addTask(taskItem, at: destinationIndexPath.section)
                        tableView.insertSections([destinationIndexPath.section, destinationIndexPath.section], with: .automatic)
                    }
                }
            }
            
            dragCoordinator.dragCompleted = true
            coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
        default:
            return
        }
    }
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter
  }()
}
