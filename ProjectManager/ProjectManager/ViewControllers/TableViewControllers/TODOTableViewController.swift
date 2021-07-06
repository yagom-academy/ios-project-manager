//
//  TODOTableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class TODOTableViewController: UITableViewController {
    private var selectIndexPath: IndexPath = []
    var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ScheduleCell.classForCoder(), forCellReuseIdentifier: "scheduleCell")
        self.tableView.separatorStyle = .none
        
        let header: UIView = {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
            header.backgroundColor = .systemGray6

            return header
        }()
        
        let headerLabel : UILabel = {
            let label = UILabel(frame: header.bounds)
            label.text = "TODO"
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()
    
        let countView: UIView = {
            let countView = UIView()
            countView.backgroundColor = .black
            countView.translatesAutoresizingMaskIntoConstraints = false
            countView.clipsToBounds = true
            countView.layer.cornerRadius = 11.5
            
            return countView
        }()
        
        countLabel = {
            let count = UILabel(frame: header.bounds)
            count.textColor = .white
            count.text = "\(Task.todoList.count)"
            count.font = UIFont.preferredFont(forTextStyle: .title3)
            count.textAlignment = .center
            count.translatesAutoresizingMaskIntoConstraints = false

            return count
        }()
        
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
        
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.isUserInteractionEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.tableHeaderView = header
                
        let padding: CGFloat = 20.0
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: padding),
            headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: padding),
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),

            countView.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 10),
            countView.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 0),
            countView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.06),
            countView.heightAnchor.constraint(equalTo: countView.widthAnchor, multiplier: 1),

            countLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor)
        ])
    }
}

extension TODOTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Task.todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
            
            if Task.todoList.count > 0 {
                cell.titleLabel.text = Task.todoList[indexPath.row].title
                cell.descriptionLabel.text = Task.todoList[indexPath.row].myDescription
                cell.dateLabel.text = "\(Task.todoList[indexPath.row].date)"
            }
            
            return cell
        }()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Task.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            countLabel.text = "\(Task.todoList.count)"
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        
        let task = Task.todoList[sourceIndexPath.row]
        Task.todoList.remove(at: sourceIndexPath.row)
        Task.todoList.insert(task, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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
        tableView.deleteRows(at: [selectIndexPath], with: .automatic)
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
            let tasks = items as! [Task]
                
            Task.todoList.insert(tasks[0], at: destinationIndexPath.row)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        let dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)

        return dropProposal
    }
}
