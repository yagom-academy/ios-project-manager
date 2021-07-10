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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectManagerTableViewCell", for: indexPath) as? TodoListCell else {
            return UITableViewCell()
        }
        
        let data = checkedTableViewData(currentTableView: tableView)
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.titleLabel.text = data[indexPath.section].title
        cell.dateLabel.text = data[indexPath.section].deadline
        cell.descriptionLabel.text = data[indexPath.section].body

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoTableViewData.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .fade)
        }
        
        todoTitleView.count.text = String(todoTableViewData.count)
    }
       
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        print("hihi")
        return true
    }

//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("drop")
//        moveItem(at: sourceIndexPath.section, to: destinationIndexPath.section)
//    }
  
//    func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
//        guard sourceIndex != destinationIndex else { return }
//
//        toDoTableView.moveSection(sourceIndex, toSection: destinationIndex)
//
//        let place = todoTableViewData[sourceIndex]
//        todoTableViewData.remove(at: sourceIndex)
//        todoTableViewData.insert(place, at: destinationIndex)
//    }
}
