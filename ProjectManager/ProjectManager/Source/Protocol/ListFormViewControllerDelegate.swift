//
//  ListFormViewControllerDelegate.swift
//  ProjectManager
//  Created by inho on 2023/01/17.
//

import Foundation

protocol ListFormViewControllerDelegate {
    func addNewItem(_ listItem: ListItem)
    func ediItem(of type: ListType, at index: Int, title: String, body: String, dueDate: Date)
}
