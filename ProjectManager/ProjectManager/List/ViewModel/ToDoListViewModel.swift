//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import CoreData

final class ToDoListViewModel: ViewModelProtocol {
    var toDoList: Observable<[ToDo]> = Observable([])
    var doingList: Observable<[ToDo]> = Observable([])
    var doneList: Observable<[ToDo]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<CoreDataError?> = Observable(nil)
    let coreDataManager: CoreDataManager
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
        
#if DEBUG
        addTestData()
#endif
    }

    func fetchData(_ status: ToDoStatus) {
        do {
            let predicated = NSPredicate(format: "status == %@", status.rawValue)
            let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")
            
            guard let result = filtered as? [ToDo] else { return }
            
            switch status {
            case .toDo:
                toDoList.value = result
            case .doing:
                doingList.value = result
            case .done:
                doneList.value = result
            }
        } catch(let error) {
            handle(error: error)
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
            CoreDataManager.Value(key: "status", value: ToDoStatus.toDo.rawValue)
        ]
        
        do {
            try coreDataManager.createData(type: ToDo.self, values: values)
            fetchData(.toDo)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func updateData(_ entity: ToDo, title: String?, body: String?, dueDate: Date?) {
        guard let status = ToDoStatus(rawValue: entity.status) else { return }
        let values: [CoreDataManager.Value] = [
            CoreDataManager.Value(key: "title", value: title),
            CoreDataManager.Value(key: "body", value: body),
            CoreDataManager.Value(key: "dueDate", value: dueDate)
        ]
        do {
            try coreDataManager.updateData(entity: entity, values: values)
            fetchData(status)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func deleteData(_ entity: ToDo) {
        guard let status = ToDoStatus(rawValue: entity.status) else { return }
        
        do {
            try coreDataManager.deleteData(entity: entity)
            fetchData(status)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func handle(error: Error) {
        if let coreDataError = error as? CoreDataError {
            self.setError(coreDataError)
        } else {
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
                CoreDataManager.Value(key: "status", value: ToDoStatus.toDo.rawValue)
            ]
            
            let doingValues: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트2"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다2"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.doing.rawValue)
            ]
            
            let doneValues: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트3"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다3"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.done.rawValue)
            ]
            
            let doneValues2: [CoreDataManager.Value] = [
                CoreDataManager.Value(key: "id", value: UUID()),
                CoreDataManager.Value(key: "title", value: "테스트4"),
                CoreDataManager.Value(key: "body", value: "테스트용입니다4"),
                CoreDataManager.Value(key: "dueDate", value: Date()),
                CoreDataManager.Value(key: "createdAt", value: Date()),
                CoreDataManager.Value(key: "status", value: ToDoStatus.done.rawValue)
            ]
            
            try coreDataManager.createData(type: ToDo.self, values: toDoValues)
            try coreDataManager.createData(type: ToDo.self, values: doingValues)
            try coreDataManager.createData(type: ToDo.self, values: doneValues)
            try coreDataManager.createData(type: ToDo.self, values: doneValues2)
            
            let toDoPredicated = NSPredicate(format: "status == %@", ToDoStatus.toDo.rawValue)
            let toDofiltered = try coreDataManager.fetchData(entityName:"ToDo", predicate: toDoPredicated, sort: "createdAt")
            let doingPredicated = NSPredicate(format: "status == %@", ToDoStatus.doing.rawValue)
            let doingfiltered = try coreDataManager.fetchData(entityName:"ToDo", predicate: doingPredicated, sort: "createdAt")
            let donePredicated = NSPredicate(format: "status == %@", ToDoStatus.done.rawValue)
            let donefiltered = try coreDataManager.fetchData(entityName:"ToDo", predicate: donePredicated, sort: "createdAt")
            
            guard let toDoResult = toDofiltered as? [ToDo],
                  let doingResult = doingfiltered as? [ToDo],
                  let doneResult = donefiltered as? [ToDo] else { return }
            
            toDoList.value = toDoResult
            doingList.value = doingResult
            doneList.value = doneResult
        } catch {
        }
    }
}
