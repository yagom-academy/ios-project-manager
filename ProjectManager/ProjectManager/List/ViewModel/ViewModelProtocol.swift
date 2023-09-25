//
//  ViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import Foundation

protocol ViewModelProtocol {
    var toDoList: Observable<[ToDo]> { get set }
    var doingList: Observable<[ToDo]> { get set }
    var doneList: Observable<[ToDo]>{ get set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<CoreDataError?> { get set }
    func fetchData(_ status: ToDoStatus)
    func createData(title: String?, body: String?, dueDate: Date?)
    func updateData(_ entity: ToDo, title: String?, body: String?, dueDate: Date?)
    func deleteData(_ entity: ToDo)
    func handle(error: Error)
    func setError(_ error: CoreDataError)
}
