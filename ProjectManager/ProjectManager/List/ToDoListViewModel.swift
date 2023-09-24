//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Min Hyun on 2023/09/24.
//

import CoreData

class ToDoListViewModel: ViewModelProtocol {
    var dataList: Observable<[ToDoStatus: [ToDo]]>
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)
    let coreDataManager: CoreDataManager
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
        dataList = Observable([:])
        addTestData()
    }
    
    func fetchData() {
        do {
            try ToDoStatus.allCases.forEach { status in
                let predicated = NSPredicate(format: "status == %@", status.name)
                let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")
                dataList.value[status] = filtered as? [ToDo]
            }
        } catch CoreDataError.dataNotFound {
            setError(CoreDataError.dataNotFound.alertMessage)
        } catch {
            setError(CoreDataError.unknown.alertMessage)
        }
    }
    
    func createData(title: String?, body: String?, dueDate: Date?) {
        guard let title, let body, let dueDate else { return }
        let values: [(key: String, value: Any?)] = [
            (key: "id", value: UUID()),
            (key: "title", value: title),
            (key: "body", value: body),
            (key: "dueDate", value: dueDate),
            (key: "createdAt", value: Date()),
            (key: "status", value: ToDoStatus.todo.name)
        ]
        do {
            try coreDataManager.createData(type: ToDo.self, values: values)
            fetchData()
        } catch CoreDataError.saveFailure {
            self.setError(CoreDataError.saveFailure.alertMessage)
        } catch {
            self.setError(CoreDataError.unknown.alertMessage)
        }
    }
    
    func updateData(_ entity: ToDo, title: String?, body: String?, dueDate: Date?) {
        let values: [(key: String, value: Any?)] = [
            (key: "title", value: title),
            (key: "body", value: body),
            (key: "dueDate", value: dueDate)
        ]
        do {
            try coreDataManager.updateData(entity: entity, values: values)
            fetchData()
        } catch CoreDataError.updateFailure {
            self.setError(CoreDataError.updateFailure.alertMessage)
        } catch {
            self.setError(CoreDataError.unknown.alertMessage)
        }
    }
    
    func deleteData(_ entity: ToDo) {
        do {
            try coreDataManager.deleteData(entity: entity)
            fetchData()
        } catch CoreDataError.deleteFailure {
            self.setError(CoreDataError.deleteFailure.alertMessage)
        } catch {
            self.setError(CoreDataError.unknown.alertMessage)
        }
    }
    
    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }
    
    func addTestData() {
        // 불러오기 테스트용
        do {
            let values: [(key: String, value: Any?)] = [
                (key: "id", value: UUID()),
                (key: "title", value: "테스트1"),
                (key: "body", value: "테스트용입니다"),
                (key: "dueDate", value: Date()),
                (key: "createdAt", value: Date()),
                (key: "status", value: ToDoStatus.todo.name)
            ]
            try coreDataManager.createData(type: ToDo.self, values: values)
            try ToDoStatus.allCases.forEach { status in
                let predicated = NSPredicate(format: "status == %@", status.name)
                let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")
                dataList.value[status] = filtered as? [ToDo]
            }
        } catch {
        }
    }
}
