//
//  ToDoViewModelProtocol.swift
//  ProjectManager
//
//  Created by Max on 2023/09/26.
//

import Foundation

final class ToDoListChildViewModel: ViewModelType {
    private let status: ToDoStatus
    var entityList: [ToDo] = []
    var action: Observable<Action?> = Observable(nil)
    weak var delegate: ToDoListBaseViewModelDelegate?
    
    var error: Observable<CoreDataError?> = Observable(nil)
    
    init(status: ToDoStatus) {
        self.status = status
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
    func updateData(_ entity: ToDo, values: [KeywordArgument]) {
        delegate?.updateData(entity, values: values, from: status)
    }
    
    func deleteData(_ entity: ToDo) {
        guard let index = entityList.firstIndex(of: entity) else { return }
        delegate?.deleteData(entity, at: index, from: status)
    }
    
    func changeStatus(_ entity: ToDo, to newStatus: ToDoStatus) {
        guard let index = entityList.firstIndex(of: entity) else { return }
        delegate?.changeStatus(entity, at: index, from: status, to: newStatus)
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
