//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/05.
//

import UIKit

import RxCocoa
import RxRelay
import RxSwift

fileprivate enum NetworkState {
    static let connected = "wifi"
    static let nonConncted = "wifi.slash"
}

fileprivate enum Current {
    static let date = Date()
}

final class TodoListViewModel {
    let todoViewData: Driver<[Todo]>
    let doingViewData: Driver<[Todo]>
    let doneViewData: Driver<[Todo]>
    let networkState: Driver<String>
    let historyList: Driver<Bool>
    let undoList: Driver<Bool>
    private let dataBase: DatabaseManagerProtocol
    private let notificationManager: NotificationManager
    
    init(dataBase: DatabaseManagerProtocol, notificationManger: NotificationManager) {
        self.dataBase = dataBase
        self.notificationManager = notificationManger
        
        self.todoViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .todo } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doingViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .doing } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.doneViewData = dataBase.todoListBehaviorRelay
            .map { $0.filter { $0.todoListItemStatus == .done } }
            .map { $0.sorted{ $0.date < $1.date } }
            .asDriver(onErrorJustReturn: [])
        
        self.networkState = self.dataBase.isConnected()
            .map { $0 == true ? NetworkState.connected : NetworkState.nonConncted }
            .asDriver(onErrorJustReturn: "")
        
        self.historyList = self.dataBase.historyBehaviorRelay
            .map { $0.first == nil ? false : true }
            .asDriver(onErrorJustReturn: false)
        
        self.undoList = self.dataBase.undoBehaviorRelay
            .map { $0.first == nil ? false : true }
            .asDriver(onErrorJustReturn: false)
    }
    
    func cellSelectEvent(
        indexPathRow: Int,
        todoListItemStatus: TodoListItemStatus?,
        completion: @escaping (Todo) -> Void
    ) {
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }
        
        switch todoListItemStatus {
        case .todo:
            self.todoViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        case .doing:
            self.doingViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        case .done:
            self.doneViewData.drive(onNext: {
                completion($0[indexPathRow])
            })
            .dispose()
        }
    }
    
    func cellDeleteEvent(selectedTodo: Todo) {
        self.dataBase.delete(todoID: selectedTodo.identifier)
        self.notificationManager.deleteNotification(todoIdentifier: selectedTodo.identifier.uuidString)
    }
    
    func extractNotIncludedMenuType(from todo: Todo) -> (TodoListItemStatus, TodoListItemStatus) {
        switch todo.todoListItemStatus {
        case .todo: return (.doing, .done)
        case .doing: return (.todo, .done)
        case .done: return (.todo, .doing)
        }
    }
    
    func changeTodoListItemStatus(to: TodoListItemStatus, from selectedCell: Todo) {
        var selectedTodo = selectedCell
        
        guard let newStatus = TodoListItemStatus(rawValue: to.rawValue) else {
            return
        }
        
        selectedTodo.todoListItemStatus = newStatus
        self.dataBase.update(selectedTodo: selectedTodo)
    }
    
    func changeDateLabelColor(in cell: TodoListCell, from todoData: Todo) {
        if todoData.date < Current.date && todoData.todoListItemStatus != .done {
            cell.changeDateLabelColor(to: .red)
        } else {
            cell.changeDateLabelColor(to: .black)
        }
    }
    
    func undoButtonTapEvent() {
        guard let lastHistoryData = self.dataBase.historyBehaviorRelay.value.last else {
            return
        }
        
        switch lastHistoryData.action {
        case .moved:
            self.dataBase.update(selectedTodo: lastHistoryData.lastTodo())
        case .added:
            self.dataBase.delete(todoID: lastHistoryData.identifier)
        case .edited:
            self.dataBase.update(selectedTodo: lastHistoryData.lastTodo())
        case .removed:
            self.dataBase.create(todoData: lastHistoryData.lastTodo())
        }
        self.delete(lastHistoryData: lastHistoryData)
        
        let redoList = self.dataBase.undoBehaviorRelay.value
        self.dataBase.undoBehaviorRelay.accept(redoList + [lastHistoryData])
    }
    
    func redoButtonTapEvent() {
        guard let lastUndoData = self.dataBase.undoBehaviorRelay.value.last else {
            return
        }
        
        switch lastUndoData.action {
        case .moved:
            self.dataBase.update(selectedTodo: lastUndoData.currentTodo())
        case .added:
            self.dataBase.create(todoData: lastUndoData.currentTodo())
        case .edited:
            self.dataBase.update(selectedTodo: lastUndoData.currentTodo())
        case .removed:
            self.dataBase.delete(todoID: lastUndoData.identifier)
        }
        
        self.delete(lastUndoData: lastUndoData)
    }
    
    private func delete(lastHistoryData: History) {
        for _ in 0...1 {
            let lastHistoryData = self.dataBase.historyBehaviorRelay.value.last
            let historyItems = self.dataBase.historyBehaviorRelay.value.filter { $0 != lastHistoryData }
            self.dataBase.historyBehaviorRelay.accept(historyItems)
        }
    }
    
    private func delete(lastUndoData: History) {
        let lastUndoData = self.dataBase.undoBehaviorRelay.value.last
        let historyItems = self.dataBase.undoBehaviorRelay.value.filter { $0 != lastUndoData }
        self.dataBase.undoBehaviorRelay.accept(historyItems)
    }
}
