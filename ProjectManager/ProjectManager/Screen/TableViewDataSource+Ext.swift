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
        cell.descriptionLabel.text = data[indexPath.section].body

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .fade)
        }
        
        todoTitleView.count.text = String(data.count)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        moveItem(at: sourceIndexPath.section, to: destinationIndexPath.section)
    }
    
    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        
        let place = data[sourceIndex]
        data.remove(at: sourceIndex)
        data.insert(place, at: destinationIndex)
    }
}
