//
//  ChangeStatusViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/10/06.
//

final class ChangeStatusViewModel: ToDoChangeStatusViewModelType, ToDoChangeStatusViewModelOutputsType {
    weak var delegate: ToDoListChildViewModelDelegate?
    
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<CoreDataError?> = Observable(nil)
    
    var inputs: ToDoChangeStatusViewModelInputsType { return self }
    var outputs: ToDoChangeStatusViewModelOutputsType { return self }
}

extension ChangeStatusViewModel: ViewModelTypeWithError {
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

extension ChangeStatusViewModel: ToDoChangeStatusViewModelInputsType {
    func touchUpButton(_ entity: ToDo, status: ToDoStatus) {
        delegate?.changeStatus(entity, to: status)
    }
}
