//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/31.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    private let history: [String]
    
    init(history: [String]) {
        self.history = history

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = history[indexPath.row]

        return cell
    }
}
