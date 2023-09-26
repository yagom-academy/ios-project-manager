//
//  ToDoViewModelProtocol.swift
//  ProjectManager
//
//  Created by Max on 2023/09/26.
//

import Foundation

final class ToDoListChildViewModel: ViewModelProtocol {
    private let status: ToDoStatus
    var entityList: Observable<[ToDo]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<CoreDataError?> = Observable(nil)
    weak var delegate: ToDoListBaseViewModelDelegate?
    
    init(status: ToDoStatus) {
        self.status = status
    }
    
    func fetchData() {
        delegate?.fetchDataByStatus(for: status)
    }
    
    func createData(values: [KeywordArgument]) {
        delegate?.createData(values: values)
    }
    
    func updateData(_ entity: ToDo, values: [KeywordArgument]) {
        delegate?.updateData(entity, values: values)
        fetchData()
    }
    
    func deleteData(_ entity: ToDo) {
        delegate?.deleteData(entity)
        fetchData()
    }
}

extension ToDoListChildViewModel {
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

#if DEBUG
extension ToDoListChildViewModel {
    func addTestData() {
        // 불러오기 테스트용
        let values: [KeywordArgument] = [
            KeywordArgument(key: "id", value: UUID()),
            KeywordArgument(key: "title", value: "\(status.rawValue) 테스트1"),
            KeywordArgument(key: "body", value: "테스트용입니다"),
            KeywordArgument(key: "dueDate", value: Date()),
            KeywordArgument(key: "createdAt", value: Date()),
            KeywordArgument(key: "status", value: status.rawValue)
        ]
        
        let values2: [KeywordArgument] = [
            KeywordArgument(key: "id", value: UUID()),
            KeywordArgument(key: "title", value: "\(status.rawValue) 테스트2"),
            KeywordArgument(key: "body", value: "테스트용입니다2"),
            KeywordArgument(key: "dueDate", value: Date()),
            KeywordArgument(key: "createdAt", value: Date()),
            KeywordArgument(key: "status", value: status.rawValue)
        ]
        
        delegate?.createData(values: values)
        delegate?.createData(values: values2)
        
        fetchData()
    }
}
#endif
