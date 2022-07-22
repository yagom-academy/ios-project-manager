//
//  MasterViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/22.
//

import UIKit


class HistoryViewController: UITableViewController {
    var histories: [History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        navigationItem.hidesBackButton = true
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(test(notification:)), name: Notification.Name("Append"), object: nil)
    }
    
    @objc func test(notification: Notification) {
        if let dic = notification.userInfo as? [String: Any],
           let title = dic["title"] as? String,
           let time = dic["time"] as? Double {
            let history = History(action: title, time: time)
            self.histories.append(history)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HistoryCell.identifier,
            for: indexPath)
                as? HistoryCell else {
            return UITableViewCell()
        }
        
        cell.setupContents(history: histories[indexPath.row])
        
        return cell
    }
}

