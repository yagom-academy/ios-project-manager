//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/31.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    private let histories: [History]
    
    init(histoies: [History]) {
        self.histories = histoies

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier) as? HistoryCell {
            cell.updateLabel(by: histories[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}
