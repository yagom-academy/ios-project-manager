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
    
        configureCell(cell: cell, tableView: tableView, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newTodoFormNavigationController = NewTodoFormNavigationController(rootViewController: newTodoFormViewController)
        let data = distinguishedTableViewData(currentTableView: tableView)
        newTodoFormNavigationController.modalPresentationStyle = .formSheet
        
        newTodoFormViewController.mode = "Edit"
        
        newTodoFormViewController.newTodoFormTextField.text = data[indexPath.row].title
        newTodoFormViewController.newTodoFormTextView.text = data[indexPath.row].body
        newTodoFormViewController.datePicker.date = Date(timeIntervalSince1970: data[indexPath.row].deadline)
        
        newTodoFormViewController.newTodoFormTextField.isUserInteractionEnabled = false
        newTodoFormViewController.newTodoFormTextView.isUserInteractionEnabled = false
        newTodoFormViewController.datePicker.isUserInteractionEnabled = false
        
        present(newTodoFormNavigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeElement(tableView: tableView, indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        reloadCountLabel()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row, tableView: tableView)
    }
}
