//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/17.
//

import RxSwift
import UIKit

final class ProjectManagerViewModel: ProjectManagerViewModelType {
    
    // MARK: - Properties
    
    private var provider = TodoDataProvider()
    private var disposeBag = DisposeBag()

    // MARK: - Transform Methods
    
    func transform(viewInput: ProjectManagerViewInput) -> ProjectManagerViewOutput {
        let error = PublishSubject<Error>()
        let viewModels = BehaviorSubject<[TodoStatus: CellViewModelType]>(value: [:])
        let alertController = PublishSubject<UIAlertController>()
        var dummyViewModels: [TodoStatus: CellViewModelType] = [:]
        
        TodoStatus.allCases.forEach { status in
            switch status {
            case .todo:
                dummyViewModels[status] = TodoViewModel(
                    statusType: .todo,
                    mainViewModel: self
                )
            case .doing:
                dummyViewModels[status] = DoingViewModel(
                    statusType: .doing,
                    mainViewModel: self
                )
            case .done:
                dummyViewModels[status] = DoneViewModel(
                    statusType: .done,
                    mainViewModel: self
                )
            }
        }
        viewModels.onNext(dummyViewModels)
        
        viewInput.doneAction?
            .subscribe(onNext: { todo in
                guard let todo = todo else {
                    error.onNext(TodoError.initializingFailed)
                    return
                }
                
                guard todo.title.isEmpty == false else {
                    error.onNext(TodoError.emptyTitle)
                    return
                }
                
                self.provider.saveTodoData(
                    document: todo.identity.uuidString,
                    todoData: todo
                )
            })
            .disposed(by: disposeBag)
        
        error
            .subscribe(onNext: { error in
                let newAlertController = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let newAction = UIAlertAction(title: "확인", style: .cancel)
                newAlertController.addAction(newAction)
                newAlertController.modalPresentationStyle = .formSheet
                
                alertController.onNext(newAlertController)
            })
            .disposed(by: disposeBag)
        
        return ProjectManagerViewOutput(allTodoList: provider.allTodoList, errorAlertContoller: alertController, viewModels: viewModels)
    }
    
    func transform(modelInput: ProjectManagerModelInput) -> ProjectManagerModelOutput {
        let error = PublishSubject<Error>()

        modelInput.saveAction?
            .subscribe(onNext: { todo in
                guard let todo = todo else {
                    error.onNext(TodoError.initializingFailed)
                    return
                }
                
                guard todo.title.isEmpty == false else {
                    error.onNext(TodoError.emptyTitle)
                    return
                }
                
                self.provider.saveTodoData(
                    document: todo.identity.uuidString,
                    todoData: todo
                )
            })
            .disposed(by: disposeBag)
        
        modelInput.deleteAction?
            .subscribe(onNext: { todo in
                self.provider.deleteTodoData(document: todo.identity.uuidString)
            })
            .disposed(by: disposeBag)
        
        modelInput.moveToAction?
            .subscribe(onNext: { todo in
                self.provider.saveTodoData(
                    document: todo.identity.uuidString,
                    todoData: todo
                )
            })
            .disposed(by: disposeBag)
        
        return ProjectManagerModelOutput(allTodoList: provider.allTodoList, error: error)
    }
}
