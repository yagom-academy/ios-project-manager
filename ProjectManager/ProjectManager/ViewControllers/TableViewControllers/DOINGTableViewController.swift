//
//  DOINGTableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class DOINGTableViewController: UITableViewController {

    private var selectIndexPath: IndexPath = []
    var header: UIView!
    var headerLabel: UILabel!
    var countLabel: UILabel!
    var countView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ScheduleCell.classForCoder(), forCellReuseIdentifier: "scheduleCell")
        tableView.separatorStyle = .none
        
        tableView.isUserInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureTableView()
    }
}

extension DOINGTableViewController {

    func configureTableView() {
        header = {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
            header.backgroundColor = .systemGray6

            return header
        }()
        
        headerLabel = {
            let label = UILabel(frame: header.bounds)
            label.text = "DOING"
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()
    
        countView = {
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
            count.text = "\(Task.doingList.count)"
            count.font = UIFont.preferredFont(forTextStyle: .title3)
            count.textAlignment = .center
            count.translatesAutoresizingMaskIntoConstraints = false

            return count
        }()
        
        tableView.tableHeaderView = header
        tableView.backgroundColor = .systemGray6
        
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
        
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

extension DOINGTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countLabel.text = "\(Task.doingList.count)"
        return Task.doingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        cell.prepareForReuse()
        cell.task = Task.doingList[indexPath.row]
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
            Task.doingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            countLabel.text = "\(Task.doingList.count)"
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        
        let task = Task.doingList[sourceIndexPath.row]
        Task.doingList.remove(at: sourceIndexPath.row)
        Task.doingList.insert(task, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editViewController = EditViewController()
        let navigationController = UINavigationController(rootViewController: editViewController)
        
        editViewController.indexPath = indexPath
        editViewController.task = Task.doingList[indexPath.row]
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

extension DOINGTableViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        selectIndexPath = indexPath
        let item = Task.doingList[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        Task.doingList.remove(at: selectIndexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [selectIndexPath], with: .none)
        tableView.endUpdates()
    }
}

extension DOINGTableViewController: UITableViewDropDelegate {

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
            tasks[0].status = "DOING"
            Task.doingList.insert(tasks[0], at: destinationIndexPath.row)
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
