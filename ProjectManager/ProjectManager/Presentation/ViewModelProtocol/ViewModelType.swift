//
//  ViewModel.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

protocol ViewModelTypeWithError {
    associatedtype ViewModelError
    
    var error: Observable<ViewModelError?> { get set }

    func handle(error: Error)
    func setError(_ error: ViewModelError)
}

protocol ToDoBaseViewModelType {
    var inputs: ToDoBaseViewModelInputsType { get }
    var outputs: ToDoBaseViewModelOutputsType { get }
}

protocol ToDoBaseViewModelInputsType {
    func addChild(_ status: ToDoStatus) -> ToDoListChildViewModel
    func createData(values: [KeywordArgument])
}

protocol ToDoBaseViewModelOutputsType {
    var error: Observable<CoreDataError?> { get set }
}

protocol ToDoChildViewModelType {
    var inputs: ToDoChildViewModelInputsType { get }
    var outputs: ToDoChildViewModelOutputsType { get }
}

protocol ToDoChildViewModelInputsType {
    func viewWillAppear()
    func swipeToDelete(_ entity: ToDo)
}

protocol ToDoChildViewModelOutputsType {
    var action: Observable<Output?> { get }
    var entityList: [ToDo] { get }
    var error: Observable<CoreDataError?> { get set }
}

protocol ToDoChangeStatusViewModelType {
    var inputs: ToDoChangeStatusViewModelInputsType { get }
    var outputs: ToDoChangeStatusViewModelOutputsType { get }
}

protocol ToDoChangeStatusViewModelInputsType {
    func touchUpButton(_ entity: ToDo, status: ToDoStatus)
}

protocol ToDoChangeStatusViewModelOutputsType {
    var error: Observable<CoreDataError?> { get set }
}
