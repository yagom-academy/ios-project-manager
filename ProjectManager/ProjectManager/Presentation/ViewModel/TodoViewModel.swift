//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

extension TodoView {
    final class ViewModel: ObservableObject {
        @Published var tasks: [Task] = []
        
        func createTask() {
            tasks.append(Task(title: "test", content: "sdfsdf", date: .now))
        }        
    }
}
