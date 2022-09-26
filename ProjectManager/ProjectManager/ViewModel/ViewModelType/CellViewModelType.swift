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
    
    var provider: TodoDataProvider { get set }
    var statusType: TodoStatus? { get set }
    var disposeBag: DisposeBag { get set }
    
    init()
    init(statusType: TodoStatus)

    func transform(viewInput: CellViewInput) -> CellViewOutput
}

extension CellViewModelType {
    
    // MARK: - Life Cycle
    
    init(statusType: TodoStatus) {
        self.init()
        
        provider = TodoDataProvider.shared
        disposeBag = DisposeBag()

        self.statusType = statusType
    }
    
    // MARK: - Transform Method
    
    func transform(viewInput: CellViewInput) -> CellViewOutput {
        var categorizedTodoList: Observable<[Todo]>
        let alertContoller = PublishSubject<UIAlertController>()
        
        categorizedTodoList = provider.allTodoList
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
        
        viewInput.doneAction?
            .withLatestFrom(categorizedTodoList) { ($0.0, $1[$0.1.row]) }
            .compactMap { todo, oldTodo in
                var newTodo = todo

                newTodo?.identity = oldTodo.identity
                newTodo?.status = oldTodo.status
                newTodo?.isOutdated = oldTodo.isOutdated

                return newTodo
            }
            .subscribe(onNext: { [weak self] todo in
                self?.provider.saveTodoData(document: todo.identity, todoData: todo)
            })
            .disposed(by: disposeBag)
        
        viewInput.deleteAction?
            .withLatestFrom(categorizedTodoList) { todoIndex, categorizedTodoList in
                categorizedTodoList[todoIndex]
            }
            .subscribe(onNext: { [weak self] todo in
                self?.provider.deleteTodoData(document: todo.identity)
            })
            .disposed(by: disposeBag)
        
        viewInput.moveToAction?
            .filter { $0.1.state == .began }
            .map { ($0.0, $0.1.location(in: $0.0)) }
            .map { ($0.0, $0.0.indexPathForRow(at: $0.1)) }
            .withLatestFrom(categorizedTodoList) { ($0.0, $0.1, $1) }
            .subscribe(onNext: { [weak self] (tableView, indexPath, categorizedTodoList) in
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
                        self?.provider.saveTodoData(document: newTodo.identity, todoData: newTodo)
                    }
                    newAlertContoller.addAction(newAction)
                }
                
                self?.setupPopup(
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
