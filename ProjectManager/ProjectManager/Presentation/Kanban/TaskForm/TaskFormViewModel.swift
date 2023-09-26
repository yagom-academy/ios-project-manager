//
//  TaskFormViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/22.
//

import SwiftUI

final class TaskFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = Date()
    
    var task: Task {
        Task(title: title, content: content, date: date)
    }
}
