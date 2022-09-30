//
//  ProjectHistoryTableViewController.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/29.
//

import UIKit

final class ProjectHistoryTableViewController: UITableViewController {
    // MARK: - Properties
    
    private var viewModel = ProjectHistoryViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(ProjectHistroyTableViewCell.self,
                           forCellReuseIdentifier: ProjectHistroyTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Methods
    
    func setHistory(_ history: [String]) {
        viewModel.setHistory(history)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectHistroyTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ProjectHistroyTableViewCell
        else { return UITableViewCell() }
        
        viewModel.configureCellItem(cell: cell,
                                    indexPath: indexPath)
        
        return cell
    }
}
