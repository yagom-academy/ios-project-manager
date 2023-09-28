//
//  TaskCreator.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/29.
//

import SwiftUI

final class TaskCreator: TaskFormProtocol {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = .now
    
    let formTitle: String = "Todo"    
    let formSize: CGSize
    
    init(formSize: CGSize) {
        self.formSize = formSize
    }
    
    var task: Task {
        Task(
            id: UUID(),
            title: title,
            content: content,
            date: date,
            state: .todo
        )
    }
    
    var formMode: FormMode {
        .create
    }
    
    var isEditable: Bool {
        get { true }
        set { }        
    }
}
