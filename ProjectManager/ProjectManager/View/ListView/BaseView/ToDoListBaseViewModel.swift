//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import CoreData

final class ToDoListBaseViewModel: ViewModelType {
    private let coreDataManager: CoreDataManager
    private var children: [ToDoStatus: ToDoListChildViewModel] = [:]

    var error: Observable<CoreDataError?> = Observable(nil)
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
    }
    
    func handle(error: Error) {
        if let coreDataError = error as? CoreDataError {
            self.setError(coreDataError)
        } else {
            self.setError(CoreDataError.unknown)
        }
    }
    
    func setError(_ error: CoreDataError) {
        self.error = Observable(error)
    }
}

extension ToDoListBaseViewModel: ToDoListBaseViewModelDelegate {
    func fetchAllData() {
        ToDoStatus.allCases.forEach { fetchDataByStatus(for: $0) }
    }
    
    func fetchDataByStatus(for status: ToDoStatus) {
        do {
            let predicated = NSPredicate(format: "status == %@", status.rawValue)
            let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "modifiedAt")
            
            guard let result = filtered as? [ToDo] else { return }
            
            children[status]?.entityList = result
            
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func createData(values: [KeywordArgument]) {
        var values = values
        
        if values.filter({ $0.key == "id" }).isEmpty {
            values.append(KeywordArgument(key: "id", value: UUID()))
        }
        
        if values.filter({ $0.key == "modifiedAt" }).isEmpty {
            values.append(KeywordArgument(key: "modifiedAt", value: Date()))
        }
        
        if values.filter({ $0.key == "status" }).isEmpty {
            values.append(KeywordArgument(key: "status", value: ToDoStatus.toDo.rawValue))
        }
        
        do {
            try coreDataManager.createData(type: ToDo.self, values: values)
            updateChild(.toDo, action: Action(type: .create))
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func updateData(_ entity: ToDo, values: [KeywordArgument], from childKey: ToDoStatus) {
        do {
            try coreDataManager.updateData(entity: entity, values: values)
            updateChild(childKey, action: Action(type: .update))
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func deleteData(_ entity: ToDo, at index: Int, from childKey: ToDoStatus) {
        do {
            try coreDataManager.deleteData(entity: entity)
            updateChild(childKey, action: Action(type: .delete, extraInformation: [KeywordArgument(key: "index", value: index)]))
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func changeStatus(_ entity: ToDo, at index: Int, from oldStatus: ToDoStatus, to newStatus: ToDoStatus) {
        do {
            try coreDataManager.updateData(entity: entity, values: [KeywordArgument(key: "status", value: newStatus.rawValue)])
            updateChild(oldStatus, action: Action(type: .delete, extraInformation: [KeywordArgument(key: "index", value: index)]))
            updateChild(newStatus, action: Action(type: .create))
        } catch(let error) {
            handle(error: error)
        }
    }
}
 
extension ToDoListBaseViewModel {
    func addChild(_ status: ToDoStatus) -> ToDoListChildViewModel {
        let child = ToDoListChildViewModel(status: status)
        children[status] = child
        child.delegate = self
#if DEBUG
        child.addTestData()
        updateChild(status, action: Action(type: .create))
#endif
        return child
    }
    
    func updateChild(_ status: ToDoStatus, action: Action) {
        fetchDataByStatus(for: status)
        children[status]?.action.value = action
    }
}

