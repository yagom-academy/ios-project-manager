//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import CoreData

protocol ToDoListBaseViewModelDelegate: AnyObject {
    func fetchData()
    func fetchDataByStatus(for status: ToDoStatus)
    func createData(values: [KeywordArgument])
    func updateData(_ entity: ToDo, values: [KeywordArgument])
    func deleteData(_ entity: ToDo)
}

final class ToDoListBaseViewModel: ViewModelProtocol, ToDoListBaseViewModelDelegate {
    private let coreDataManager: CoreDataManager
    private var children: [ToDoStatus: ToDoListChildViewModel] = [:]
    
    var entityList: Observable<[ToDo]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<CoreDataError?> = Observable(nil)
    
    init(dataManager: CoreDataManager) {
        coreDataManager = dataManager
    }
    
    func fetchData() {
        ToDoStatus.allCases.forEach { fetchDataByStatus(for: $0) }
    }
    
    func fetchDataByStatus(for status: ToDoStatus) {
        do {
            let predicated = NSPredicate(format: "status == %@", status.rawValue)
            let filtered = try coreDataManager.fetchData(entityName:"ToDo", predicate: predicated, sort: "createdAt")

            guard let result = filtered as? [ToDo] else { return }
            
            children[status]?.entityList.value = result

        } catch(let error) {
            handle(error: error)
        }
    }
    
    func createData(values: [KeywordArgument]) {
        var values = values
        
        if values.filter({ $0.key == "id" }).isEmpty {
            values.append(KeywordArgument(key: "id", value: UUID()))
        }
        
        if values.filter({ $0.key == "createdAt" }).isEmpty {
            values.append(KeywordArgument(key: "createdAt", value: Date()))
        }
        
        if values.filter({ $0.key == "status" }).isEmpty {
            values.append(KeywordArgument(key: "status", value: ToDoStatus.toDo.rawValue))
        }

        do {
            try coreDataManager.createData(type: ToDo.self, values: values)
            fetchDataByStatus(for: .toDo)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func updateData(_ entity: ToDo, values: [KeywordArgument]) {
        do {
            try coreDataManager.updateData(entity: entity, values: values)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func deleteData(_ entity: ToDo) {
        do {
            try coreDataManager.deleteData(entity: entity)
        } catch(let error) {
            handle(error: error)
        }
    }
}
    
extension ToDoListBaseViewModel {
    func addChildModel(status: ToDoStatus) -> ToDoListChildViewModel {
        let child = ToDoListChildViewModel(status: status)
        children[status] = child
        child.delegate = self
#if DEBUG
        child.addTestData()
#endif
        return child
    }
}

extension ToDoListBaseViewModel {
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
