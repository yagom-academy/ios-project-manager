//
//  TaskEditor.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/29.
//

import SwiftUI

final class TaskEditViewModel: TaskFormProtocol {
    @Published var title: String
    @Published var content: String
    @Published var date: Date
    @Published var isEditable: Bool = false
    
    private let id: UUID
    private let state: TaskState
    
    let formTitle: String
    let formSize: CGSize
    
    init(task: Task, formSize: CGSize) {
        self.id = task.id
        self.state = task.state
        self.title = task.title
        self.content = task.content
        self.date = task.date
        self.formTitle = task.state.title
        self.formSize = formSize
    }
    
    var task: Task {
        Task(
            id: id,
            title: title,
            content: content,
            date: date,
            state: state
        )
    }
    
    var formMode: FormMode {
        .edit
    }    
}

