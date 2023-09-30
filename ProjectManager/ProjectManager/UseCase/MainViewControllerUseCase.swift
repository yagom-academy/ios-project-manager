//
//  MainViewControllerUseCase.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/30.
//

import UIKit

protocol MainViewControllerUseCase {
    var todoItems: [ProjectManager] { get set }
    var doingItems: [ProjectManager] { get set }
    var doneItems: [ProjectManager] { get set }
    func updateItems(_ items: [ProjectManager]?, title: String, body: String, date: Date, index: Int, tableView: UITableView) -> [ProjectManager]
}

final class MainViewControllerUseCaseImplementation: MainViewControllerUseCase {
    var todoItems = [ProjectManager]()
    var doingItems = [ProjectManager]()
    var doneItems = [ProjectManager]()
    
    func updateItems(_ items: [ProjectManager]?, title: String, body: String, date: Date, index: Int, tableView: UITableView) -> [ProjectManager] {
        guard var mutableItems = items,
              index >= 0 && index < mutableItems.count else {
            return items ?? []
        }
        
        mutableItems[index].title = title
        mutableItems[index].body = body
        mutableItems[index].date = date
        tableView.reloadData()
        
        return mutableItems
    }
}
