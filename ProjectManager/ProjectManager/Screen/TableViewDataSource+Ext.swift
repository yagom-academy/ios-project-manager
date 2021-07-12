//
//  TableViewDataSource+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/01.
//

import UIKit

extension ProjectManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = distinguishedTableViewData(currentTableView: tableView)
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectManagerTableViewCell", for: indexPath) as? TodoListCell else {
            return UITableViewCell()
        }
        
        let data = distinguishedTableViewData(currentTableView: tableView)
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.titleLabel.text = data[indexPath.row].title
        cell.dateLabel.text = data[indexPath.row].deadline
        cell.descriptionLabel.text = data[indexPath.row].body

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoTableViewData.remove(at: indexPath.row)
            tableView.deleteSections([indexPath.row], with: .fade)
        }
        
        todoTitleView.count.text = String(todoTableViewData.count)
    }
       
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row, tableView: tableView)
    }
}
