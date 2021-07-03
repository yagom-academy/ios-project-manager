//
//  DONETableViewController.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/29.
//

import UIKit

class DONETableViewController: UITableViewController {
    static var doneLists: [Task] = []
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
            count.text = "\(TODOTableViewController.todoLists.count)"
            count.font = UIFont.preferredFont(forTextStyle: .title3)
            count.textAlignment = .center
            count.translatesAutoresizingMaskIntoConstraints = false

            return count
        }()
        
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODOTableViewController.todoLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
            
            if TODOTableViewController.todoLists.count > 0 {
                cell.titleLabel.text = TODOTableViewController.todoLists[indexPath.row].title
                cell.descriptionLabel.text = TODOTableViewController.todoLists[indexPath.row].description
                cell.dateLabel.text = "\(TODOTableViewController.todoLists[indexPath.row].date)"
            }
            
            return cell
        }()

        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        }
    }
}
