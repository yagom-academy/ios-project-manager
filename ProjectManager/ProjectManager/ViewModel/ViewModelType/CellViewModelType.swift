//
//  CellViewModelType.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/16.
//

import RxSwift
import UIKit

protocol CellViewModelType: AnyObject {
    
    // MARK: - Properties
    
    var statusType: TodoStatus? { get set }
    
    var mainViewModel: ProjectManagerViewModelType? { get set }
    
    var saveSubject: PublishSubject<Todo?> { get set }
    var deleteSubject: PublishSubject<Todo> { get set }
    var moveToSubject: PublishSubject<Todo> { get set }
    
    var modelOutput: ProjectManagerModelOutput? { get set }
    var disposeBag: DisposeBag { get set }
    
    init()
    init(statusType: TodoStatus, mainViewModel: ProjectManagerViewModelType)

    func transform(viewInput: CellViewInput) -> CellViewOutput
}

extension CellViewModelType {
    
    // MARK: - Life Cycle
    
    init(statusType: TodoStatus, mainViewModel: ProjectManagerViewModelType) {
        self.init()
        
        saveSubject = PublishSubject<Todo?>()
        deleteSubject = PublishSubject<Todo>()
        moveToSubject = PublishSubject<Todo>()
        disposeBag = DisposeBag()
        
        guard let mainViewModel = mainViewModel as? ProjectManagerViewModel else { return }
        self.mainViewModel = mainViewModel
        self.statusType = statusType
        
        let modelInput = ProjectManagerModelInput(
            saveAction: saveSubject,
            deleteAction: deleteSubject,
            moveToAction: moveToSubject
        )
        modelOutput = mainViewModel.transform(modelInput: modelInput)
    }
    
    // MARK: - Transform Method
    
    func transform(viewInput: CellViewInput) -> CellViewOutput {
        let categorizedTodoList = BehaviorSubject<[Todo]>(value: [])
        let alertContoller = PublishSubject<UIAlertController>()
        
        modelOutput?.allTodoList?
            .map { $0.filter { $0.status == self.statusType } }
            .map { $0.map { todo in
                var newTodo = todo
                newTodo.isOutdated = false

                if let flatTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: todo.createdAt),
                      let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: flatTime),
                      Date() > nextDay {
                    newTodo.isOutdated = true
                }

                return newTodo
            }}
            .subscribe(onNext: { categorizedTodoList.onNext($0) })
            .disposed(by: disposeBag)
        
        viewInput.doneAction?
            .withLatestFrom(categorizedTodoList) { ($0.0, $1[$0.1.row]) }
            .map { todo, oldTodo in
                var newTodo = todo
                
                newTodo?.identity = oldTodo.identity
                newTodo?.status = oldTodo.status
                newTodo?.isOutdated = oldTodo.isOutdated
                
                return newTodo
            }
            .subscribe(onNext: { todo in
                self.saveSubject.onNext(todo)
            })
            .disposed(by: disposeBag)
        
        viewInput.deleteAction?
            .withLatestFrom(categorizedTodoList) { todoIndex, categorizedTodoList in
                categorizedTodoList[todoIndex]
            }
            .subscribe(onNext: { todo in
                self.deleteSubject.onNext(todo)
            })
            .disposed(by: disposeBag)
        
        viewInput.moveToAction?
            .filter { $0.1.state == .began }
            .map { ($0.0, $0.1.location(in: $0.0)) }
            .map { ($0.0, $0.0.indexPathForRow(at: $0.1)) }
            .withLatestFrom(categorizedTodoList) { ($0.0, $0.1, $1) }
            .subscribe(onNext: { (tableView, indexPath, categorizedTodoList) in
                guard let indexPath = indexPath else { return }

                let currentCell = tableView.cellForRow(at: indexPath)
                let currentTodo = categorizedTodoList[indexPath.row]
                let newAlertContoller = UIAlertController()
                var newTodo = currentTodo

                let filteredStatus = TodoStatus.allCases.filter {
                    $0 != currentTodo.status
                }

                filteredStatus.forEach { todoStatus in
                    let newAction = UIAlertAction(
                        title: "Move to \(todoStatus.upperCasedString)",
                        style: .default
                    ) { _ in
                        newTodo.status = todoStatus
                        self.moveToSubject.onNext(newTodo)
                    }
                    newAlertContoller.addAction(newAction)
                }
                
                self.setupPopup(
                    alertController: newAlertContoller,
                    selectedCell: currentCell
                )

                alertContoller.onNext(newAlertContoller)
            })
            .disposed(by: disposeBag)
        
        return CellViewOutput(categorizedTodoList: categorizedTodoList, moveToAlertController: alertContoller)
    }
    
    // MARK: - Other Methods
    
    func setupPopup(alertController: UIAlertController, selectedCell: UITableViewCell?) {
        
        guard let selectedCell = selectedCell else { return }
        
        let popoverPresentationController = alertController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = selectedCell
        popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: 0,
            width: selectedCell.frame.width,
            height: selectedCell.frame.height / 2
        )
        
        alertController.modalPresentationStyle = .popover
    }
}
