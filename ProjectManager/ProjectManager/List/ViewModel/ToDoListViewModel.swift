//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import CoreData

final class ToDoListViewModel: ViewModelProtocol {
    var dataList: Observable<[ToDoStatus: [ToDo]]> = Observable([:])
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<CoreDataError?> = Observable(nil)
    let coreDataManager: CoreDataManager
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
        
#if DEBUG
        addTestData()
#endif
    }
    
    func fetchData() {
        do {
            try ToDoStatus.allCases.forEach { status in
                let predicated = NSPredicate(format: "status == %@", status.name)
                let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")
                dataList.value[status] = filtered as? [ToDo]
            }
        } catch CoreDataError.dataNotFound {
            setError(CoreDataError.dataNotFound)
        } catch {
            setError(CoreDataError.unknown)
        }
    }
    
    func createData(title: String?, body: String?, dueDate: Date?) {
        guard let title, let body, let dueDate else { return }
        let values: [CoreDataManager.Value] = [
            CoreDataManager.Value(key: "id", value: UUID()),
            CoreDataManager.Value(key: "title", value: title),
            CoreDataManager.Value(key: "body", value: body),
            CoreDataManager.Value(key: "dueDate", value: dueDate),
            CoreDataManager.Value(key: "createdAt", value: Date()),
            CoreDataManager.Value(key: "status", value: ToDoStatus.toDo.name)
        ]
        
        do {
            try coreDataManager.createData(type: ToDo.self, values: values)
            fetchData()
        } catch CoreDataError.saveFailure {
            self.setError(CoreDataError.saveFailure)
        } catch {
            self.setError(CoreDataError.unknown)
        }
    }
    
    func updateData(_ entity: ToDo, title: String?, body: String?, dueDate: Date?) {
        let values: [CoreDataManager.Value] = [
            CoreDataManager.Value(key: "title", value: title),
            CoreDataManager.Value(key: "body", value: body),
            CoreDataManager.Value(key: "dueDate", value: dueDate)
        ]
        do {
            try coreDataManager.updateData(entity: entity, values: values)
            fetchData()
        } catch CoreDataError.updateFailure {
            self.setError(CoreDataError.updateFailure)
        } catch {
            self.setError(CoreDataError.unknown)
        }
    }
    
    func deleteData(_ entity: ToDo) {
        do {
            try coreDataManager.deleteData(entity: entity)
            fetchData()
        } catch CoreDataError.deleteFailure {
            self.setError(CoreDataError.deleteFailure)
        } catch {
            self.setError(CoreDataError.unknown)
        }
    }
    
    func setError(_ error: CoreDataError) {
        self.errorMessage = Observable(error.alertMessage)
        self.error = Observable(error)
    }
}

extension ToDoListViewModel {
    func addTestData() {
        // 불러오기 테스트용
        do {
            let toDoValues: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.toDo.name)
            ]
            
            let doingValues: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트2"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다2"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.doing.name)
            ]
            
            let doneValues: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트3"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다3"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.done.name)
            ]
            
            let doneValues2: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트4"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다4"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.done.name)
            ]
            
            try coreDataManager.createData(type: ToDo.self, values: toDoValues)
            try coreDataManager.createData(type: ToDo.self, values: doingValues)
            try coreDataManager.createData(type: ToDo.self, values: doneValues)
            try coreDataManager.createData(type: ToDo.self, values: doneValues2)
            
            try ToDoStatus.allCases.forEach { status in
                let predicated = NSPredicate(format: "status == %@", status.name)
                let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")
                dataList.value[status] = filtered as? [ToDo]
            }
        } catch {
        }
    }
}

extension ToDoListViewModel {
    
}
