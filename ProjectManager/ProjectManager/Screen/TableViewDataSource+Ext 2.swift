//
//  TableViewDataSource+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

extension ProjectManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectManagerTableViewCell") as? TodoListCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.titleLabel.text = data[indexPath.section].title
        cell.dateLabel.text = data[indexPath.section].deadline
        cell.descriptionLabel.text = data[indexPath.section].description

        return cell
    }
}
