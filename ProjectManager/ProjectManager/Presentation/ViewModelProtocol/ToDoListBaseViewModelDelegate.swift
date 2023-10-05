//
//  ToDoListViewModelDelegate.swift
//  ProjectManager
//
//  Created by Max on 2023/10/03.
//

protocol ToDoListBaseViewModelDelegate: AnyObject {
    func updateChild(_ status: ToDoStatus, action: Output) throws
#if DEBUG
    func createData(values: [KeywordArgument])
#endif
}
