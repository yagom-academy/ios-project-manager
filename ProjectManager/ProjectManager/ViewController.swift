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
    @IBOutlet weak var todoCountLabel: UILabel!
    @IBOutlet weak var doingCountLabel: UILabel!
    @IBOutlet weak var doneCountLabel: UILabel!
    
    private lazy var todoDataSource: TaskDataSource = TaskDataSource(tasks: todos)
    private lazy var doingDataSource: TaskDataSource = TaskDataSource(tasks: doings)
    private lazy var doneDataSource: TaskDataSource = TaskDataSource(tasks: dones)
    private let cellNibName = UINib(nibName: TableViewCell.identifier, bundle: nil)
    var todos = [Task]()
    var doings = [Task]()
    var dones = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        setTableView(todoTableView, todos)
        setTableView(doingTableView, doings)
        setTableView(doneTableView, dones)
        
        setLabelToCircle()
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
    
    
    private func setLabelToCircle() {
        todoCountLabel.layer.masksToBounds = true
        doingCountLabel.layer.masksToBounds = true
        doneCountLabel.layer.masksToBounds = true
        
        todoCountLabel.layer.cornerRadius = 0.5 * todoCountLabel.bounds.size.width
        doingCountLabel.layer.cornerRadius = 0.5 * doingCountLabel.bounds.size.width
        doneCountLabel.layer.cornerRadius = 0.5 * doneCountLabel.bounds.size.width
        
        todoCountLabel.text = "\(todos.count)"
        doingCountLabel.text = "\(doings.count)"
        doneCountLabel.text = "\(dones.count)"
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
            print("디코드에러")
        }
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        guard let taskAlertViewController = self.storyboard?.instantiateViewController(identifier: "TaskAlert") else { return }
        
        taskAlertViewController.modalPresentationStyle = .formSheet
        taskAlertViewController.modalTransitionStyle =  .crossDissolve
        self.present(taskAlertViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 7))

        headerView.backgroundColor = .systemGray6
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
}

extension ViewController: UITableViewDragDelegate {
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

extension ViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
      return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func makePlaceholder(_ destinationIndexPath: IndexPath) -> UITableViewDropPlaceholder {
        let placeholder = UITableViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: TableViewCell.identifier, rowHeight: 150)
        
        placeholder.cellUpdateHandler = { cell in
            if let cell = cell as? TableViewCell {
                cell.contentLabel.text = ""
                cell.dueDateLabel.text = ""
            }
        }
        return placeholder
    }

    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let dataSource = dataSourceForTableView(tableView)
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            destinationIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        }
        let item = coordinator.items[0]
     
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
