//
//  SavingItemDelegate.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/18.
//

import Foundation

protocol SavingItemDelegate: AnyObject {
    func addItem(_ item: TodoItem)
    func updateItem(at indexPath: IndexPath, by item: TodoItem)
}
