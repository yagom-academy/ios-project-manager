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
    func configureTableView(_ tableView: UITableView, dataSourceAndDelegate: UITableViewDataSource & UITableViewDelegate)
    func moveToDoing(_ item: ProjectManager)
    func moveToDone(_ item: ProjectManager)
    func moveToTodo(_ item: ProjectManager)
}

final class MainViewControllerUseCaseImplementation: MainViewControllerUseCase {
    var todoItems = [ProjectManager]()
    var doingItems = [ProjectManager]()
    var doneItems = [ProjectManager]()
    
    func configureTableView(_ tableView: UITableView, dataSourceAndDelegate: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = dataSourceAndDelegate
        tableView.delegate = dataSourceAndDelegate
        tableView.register(ListTitleCell.self, forCellReuseIdentifier: ReuseIdentifier.listTitleCell)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: ReuseIdentifier.descriptionCell)
    }
    
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
    
    func moveToDoing(_ item: ProjectManager) {
        if let index = todoItems.firstIndex(where: { $0 == item }) {
            todoItems.remove(at: index)
        } else if let index = doneItems.firstIndex(where: { $0 == item }) {
            doneItems.remove(at: index)
        }
        
        doingItems.append(item)
    }
    
    func moveToDone(_ item: ProjectManager) {
        if let index = todoItems.firstIndex(where: { $0 == item }) {
            todoItems.remove(at: index)
        } else if let index = doingItems.firstIndex(where: { $0 == item }) {
            doingItems.remove(at: index)
        }
        
        doneItems.append(item)
    }
    
    func moveToTodo(_ item: ProjectManager) {
        if let index = doingItems.firstIndex(where: { $0 == item }) {
            doingItems.remove(at: index)
        } else if let index = doneItems.firstIndex(where: { $0 == item }) {
            doneItems.remove(at: index)
        }
        
        todoItems.append(item)
    }
}
