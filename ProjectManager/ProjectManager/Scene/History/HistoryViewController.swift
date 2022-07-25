//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/22.
//

import UIKit

final class HistoryViewController: UITableViewController {
    
    private var histories: [History] = []
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        configureNavigationItems()
        registerTableViewCell()
        setupNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNavigationItems() {
        title = "History"
        navigationItem.hidesBackButton = true
    }
    
    private func registerTableViewCell() {
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appendHistoryData(notification:)),
            name: Notification.Name("History"),
            object: nil
        )
    }
    
    @objc private func appendHistoryData(notification: Notification) {
        guard let received = notification.userInfo as? [String: Any],
              let content = received["content"] as? String,
              let time = received["time"] as? Double else {
                  return
              }
        let history = History(content: content, time: time)
        self.histories.append(history)
        self.tableView.reloadData()
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
