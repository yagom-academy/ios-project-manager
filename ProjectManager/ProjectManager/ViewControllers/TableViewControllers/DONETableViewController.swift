//
//  DONETableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class DONETableViewController: UITableViewController {
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
            label.text = "DONE"
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
            count.text = "\(Task.doneList.count)"
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

extension DONETableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Task.doneList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let currentDate = Date()
        let unixCurrentDate = currentDate.timeIntervalSince1970
        
        cell.task = Task.doneList[indexPath.row]
        cell.titleLabel.text = cell.task.title
        cell.descriptionLabel.text = cell.task.myDescription
        
        let date = Date(timeIntervalSince1970: cell.task.date)
        let formatterDate = formatter.string(from: date)
        
        cell.dateLabel.text = "\(formatterDate)"
        if cell.task.date < unixCurrentDate {
            cell.dateLabel.textColor = .red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Task.doneList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            countLabel.text = "\(Task.doneList.count)"
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        
        let task = Task.doneList[sourceIndexPath.row]
        Task.doneList.remove(at: sourceIndexPath.row)
        Task.doneList.insert(task, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension DONETableViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        selectIndexPath = indexPath
        let item = Task.doneList[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        Task.doneList.remove(at: selectIndexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [selectIndexPath], with: .automatic)
        tableView.endUpdates()
    }
}

extension DONETableViewController: UITableViewDropDelegate {
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
                
            Task.doneList.insert(tasks[0], at: destinationIndexPath.row)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}
