//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//
import SwiftUI

extension TodoView {
    final class ViewModel: ObservableObject {
        @Published var todos: [Task]
        @Published var doings: [Task]
        @Published var dones: [Task]
        
        func createTask() {
            todos.append(Task(title: "TEST", content: "test", date: .now))
        }
        
        static let dummyTodos: [Task] = [
            Task(title: "제목1", content: "내용", date: .now),
            Task(title: "제목2", content: "내용", date: .now),
            Task(title: "제목3", content: "내용", date: .now),
            Task(title: "제목4", content: "내용", date: .now),
            Task(title: "제목5", content: "내용", date: .now),
        ]
        
        static let dummyDoings = [
            Task(title: "제목1", content: "내용", date: .now),
            Task(title: "제목2", content: "내용", date: .now),
        ]
        
        static let dummyDones = [
            Task(title: "제목1", content: "내용", date: .now),
            Task(title: "제목2", content: "내용", date: .now),
            Task(title: "제목3", content: "내용", date: .now),
        ]
        
        init(todos: [Task] = [], doings: [Task] = [], dones: [Task] = []) {
            self.todos = todos
            self.doings = doings
            self.dones = dones
        }
        
    }
}
