//
//  ProjectHistoryTableViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/29.
//

import UIKit

private enum Design {
    static let historySeparatedText = "\n"
}

final class ProjectHistoryTableViewController: UITableViewController {
    // MARK: - Properties
    
    private var history = [String]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(ProjectHistroyTableViewCell.self,
                           forCellReuseIdentifier: ProjectHistroyTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Methods
    
    func setHistory(_ history: [String]) {
        self.history = history
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectHistroyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ProjectHistroyTableViewCell
        else { return UITableViewCell() }
        
        let texts = history[indexPath.row].components(separatedBy: Design.historySeparatedText)
        
        cell.setItems(history: texts.first,
                      date: texts.last)
        
        return cell
    }
}
