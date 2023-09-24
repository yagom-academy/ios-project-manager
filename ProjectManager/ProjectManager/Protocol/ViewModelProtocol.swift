//
//  ViewModel.swift
//  ProjectManager
//
//  Created by Min Hyun on 2023/09/24.
//

import Foundation

protocol ViewModelProtocol {
    var dataList: Observable<[ToDoStatus: [ToDo]]> { get set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
    func fetchData()
    func createData(title: String?, body: String?, dueDate: Date?)
    func updateData(_ entity: ToDo, title: String?, body: String?, dueDate: Date?)
    func deleteData(_ entity: ToDo)
    func setError(_ message: String)
}
