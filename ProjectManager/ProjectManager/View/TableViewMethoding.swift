//
//  TableViewMethoding.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/28.
//

import UIKit

protocol TableViewMethoding {
    func saveData(of tableView: UITableView, to indexPathRow: Int) -> TodoModel?
    func countCell(of tableView: UITableView) -> Int
    func swipeAction(of tableView: UITableView, to indexPathRow: Int)
}

extension TableViewMethoding {
    func saveData(of tableView: UITableView, to indexPathRow: Int) -> TodoModel? {
        guard let tableView = tableView as? CustomTableView else { return nil }
        return tableView.data[indexPathRow]
    }
    
    func countCell(of tableView: UITableView) -> Int {
        guard let tableView = tableView as? CustomTableView else { return .zero }
        return tableView.data.count
    }
    
    func swipeAction(of tableView: UITableView, to indexPathRow: Int) {
        guard let tableView = tableView as? CustomTableView else { return }
        
        let removeData = tableView.data.remove(at: indexPathRow)
        guard let id = removeData.id else { return }
        CoreDataManager.shared.deleteDate(id: id)
    }
}

