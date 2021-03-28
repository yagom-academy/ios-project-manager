//
//  HistoryTableViewController.swift
//  ProjectManager
//
//  Created by 리나 on 2021/03/16.
//

import UIKit

final class HistoryTableViewController: UIViewController, UITableViewDataSource {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        preferredContentSize = CGSize(width: 400, height: 400)
    }
    
    // MARK: - UI
    
    private func configureTableView() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryManager.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = HistoryManager.list[indexPath.row].content
        content.secondaryText = HistoryManager.list[indexPath.row].dateString
        content.secondaryTextProperties.color = .gray
        cell.contentConfiguration = content
        return cell
    }
}
