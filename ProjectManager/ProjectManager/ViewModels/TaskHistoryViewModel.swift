//
//  TaskHistoryViewModel.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/08/01.
//

import Foundation

final class TaskHistoryViewModel {
    private var taskHistoryList: [TaskHistory] = []
    
    var taskHistoryCount: Int {
        get {
            return taskHistoryList.count
        }
    }
    
    func referTaskHistory(index: IndexPath) -> TaskHistory {
        let reversedtaskHistoryList = taskHistoryList.reversed() as [TaskHistory]
        return reversedtaskHistoryList[index.row]
    }
    
    func added(title: String) {
        let title = HistoryState.added(title: title).description
        taskHistoryList.append(TaskHistory(title: title, date: Date()))
    }
    
    func moved(title: String, at: State, to: State) {
        let title = HistoryState.moved(title: title, at: at, to: to).description
        taskHistoryList.append(TaskHistory(title: title, date: Date()))
    }
    
    func updated(atTitle: String, toTitle: String, from: State) {
        let title = HistoryState.updated(atTitle: atTitle, toTitle: toTitle, from: from).description
        taskHistoryList.append(TaskHistory(title: title, date: Date()))
    }
    
    func deleted(title: String, from: State) {
        let title = HistoryState.deleted(title: title, from: from).description
        taskHistoryList.append(TaskHistory(title: title, date: Date()))
    }
}
