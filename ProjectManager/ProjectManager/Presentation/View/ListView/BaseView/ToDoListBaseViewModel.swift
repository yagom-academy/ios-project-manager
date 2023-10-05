//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import CoreData

final class ToDoListBaseViewModel: ToDoBaseViewModelType, ToDoBaseViewModelOutputsType {
    private let coreDataManager: CoreDataManager
    private let useCase: ToDoUseCase
    private var children: [ToDoStatus: ToDoListChildViewModel] = [:]
    
    var inputs: ToDoBaseViewModelInputsType { return self }
    var outputs: ToDoBaseViewModelOutputsType { return self }
    
    var error: Observable<CoreDataError?> = Observable(nil)
    
    init(dataManager: CoreDataManager, useCase: ToDoUseCase) {
        coreDataManager = dataManager
        self.useCase = useCase
    }
}

extension ToDoListBaseViewModel: ViewModelTypeWithError {
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
    func createData(values: [KeywordArgument]) {
        do {
            try useCase.createData(values: values)
            try updateChild(.toDo, action: Output(type: .create))
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func updateChild(_ status: ToDoStatus, action: Output) throws {
        children[status]?.entityList = try useCase.fetchDataByStatus(for: status)
        children[status]?.action.value = action
    }
}
 
extension ToDoListBaseViewModel: ToDoBaseViewModelInputsType {
    func addChild(_ status: ToDoStatus) -> ToDoListChildViewModel {
        let child = ToDoListChildViewModel(status: status, useCase: useCase)
        children[status] = child
        child.delegate = self
#if DEBUG
        child.addTestData()
        do {
            try updateChild(status, action: Output(type: .create))
        } catch(let error) {
            handle(error: error)
        }
#endif
        return child
    }
}


