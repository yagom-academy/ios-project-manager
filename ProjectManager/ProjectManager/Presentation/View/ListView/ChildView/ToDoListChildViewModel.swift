//
//  ToDoViewModelProtocol.swift
//  ProjectManager
//
//  Created by Max on 2023/09/26.
//

import Foundation

final class ToDoListChildViewModel: ToDoChildViewModelType, ViewModelTypeWithError, ToDoChildViewModelOutputsType {
    private let useCase: ToDoUseCase
    
    var inputs: ToDoChildViewModelInputsType { return self }
    var outputs: ToDoChildViewModelOutputsType { return self }
    
    private let status: ToDoStatus
    var entityList: [ToDo] = []
    var action: Observable<Output?> = Observable(nil)
    weak var delegate: ToDoListBaseViewModelDelegate?
    
    var error: Observable<CoreDataError?> = Observable(nil)
    
    init(status: ToDoStatus, useCase: ToDoUseCase) {
        self.status = status
        self.useCase = useCase
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

extension ToDoListChildViewModel {
    func changeStatus(_ entity: ToDo, to newStatus: ToDoStatus) {
        guard let index = entityList.firstIndex(of: entity) else { return }
        do {
            try useCase.updateData(entity, values: [KeywordArgument(key: "status", value: newStatus.rawValue)])
            
            action.value = Output(type: .delete, extraInformation: [KeywordArgument(key: "index", value: index)])
            try delegate?.updateChild(newStatus, action: Output(type: .create))
        } catch(let error) {
            handle(error: error)
        }
    }
}

extension ToDoListChildViewModel: ToDoChildViewModelInputsType {
    func viewWillAppear() {
        do {
            entityList = try useCase.fetchDataByStatus(for: status)
            action.value = Output(type: .read)
        } catch(let error) {
            handle(error: error)
        }
    }
    
    func swipeToDelete(_ entity: ToDo) {
        guard let index = entityList.firstIndex(of: entity) else { return }
        do {
            try useCase.deleteData(entity)
            entityList = try useCase.fetchDataByStatus(for: status)
            action.value = Output(type: .delete, extraInformation: [KeywordArgument(key: "index", value: index)])
        } catch(let error) {
            handle(error: error)
        }
    }
}

#if DEBUG
extension ToDoListChildViewModel {
    func addTestData() {
        let values: [KeywordArgument] = [
            KeywordArgument(key: "id", value: UUID()),
            KeywordArgument(key: "title", value: "\(status.rawValue) 테스트1"),
            KeywordArgument(key: "body", value: "테스트용입니다"),
            KeywordArgument(key: "dueDate", value: Date()),
            KeywordArgument(key: "modifiedAt", value: Date()),
            KeywordArgument(key: "status", value: status.rawValue)
        ]
        
        let values2: [KeywordArgument] = [
            KeywordArgument(key: "id", value: UUID()),
            KeywordArgument(key: "title", value: "\(status.rawValue) 테스트2"),
            KeywordArgument(key: "body", value: "테스트용입니다2"),
            KeywordArgument(key: "dueDate", value: Date()),
            KeywordArgument(key: "modifiedAt", value: Date()),
            KeywordArgument(key: "status", value: status.rawValue)
        ]
        
        delegate?.createData(values: values)
        delegate?.createData(values: values2)
    }
}
#endif
