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
    
    private let cellNibName = UINib(nibName: TableViewCell.identifier, bundle: nil)
    var todos = [Task]()
    var doings = [Task]()
    var dones = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView(todoTableView)
        setTableView(doingTableView)
        setTableView(doneTableView)
        
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
        
        setLabelToCircle()
    }
    
    private func setTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellNibName, forCellReuseIdentifier: TableViewCell.identifier)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == todoTableView {
            return todos.count
        } else if tableView == doingTableView {
            return doings.count
        } else {
            return dones.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        if tableView == todoTableView {
            cell.configure(todos[indexPath.section])
        } else if tableView == doingTableView {
            cell.configure(doings[indexPath.section])
        } else {
            cell.configure(dones[indexPath.section])
        }
        
        return cell
    }
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter
  }()
}
