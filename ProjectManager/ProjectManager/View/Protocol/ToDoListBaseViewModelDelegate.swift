//
//  ToDoListViewModelDelegate.swift
//  ProjectManager
//
//  Created by Max on 2023/10/03.
//

protocol ToDoListBaseViewModelDelegate: AnyObject {
    func createData(values: [KeywordArgument])
    func updateData(_ entity: ToDo, values: [KeywordArgument], from childKey: ToDoStatus)
    func deleteData(_ entity: ToDo, at index: Int, from childKey: ToDoStatus)
    func changeStatus(_ entity: ToDo, at index: Int, from oldStatus: ToDoStatus, to newStatus: ToDoStatus)
}
