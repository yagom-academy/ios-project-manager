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
    
    private var provider = TodoDataProvider.shared
    private var disposeBag = DisposeBag()

    // MARK: - Transform Methods
    
    func transform(viewInput: ProjectManagerViewInput) -> ProjectManagerViewOutput {
        let error = PublishSubject<Error>()
        let alertController = PublishSubject<UIAlertController>()
        
        viewInput.doneAction?
            .subscribe(onNext: { [weak self] todo in
                guard let todo = todo else {
                    error.onNext(TodoError.initializingFailed)
                    return
                }
                
                guard todo.title.isEmpty == false else {
                    error.onNext(TodoError.emptyTitle)
                    return
                }
                
                self?.provider.saveTodoData(
                    document: todo.identity,
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
        
        return ProjectManagerViewOutput(allTodoList: provider.allTodoList, errorAlertContoller: alertController)
    }
}
