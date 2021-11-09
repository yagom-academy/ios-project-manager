//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/03.
//

import Foundation

class ProjectManagerViewModel: ObservableObject {
    @Published var todo: [ProjectModel] = []
    @Published var doing: [ProjectModel] = []
    @Published var done: [ProjectModel] = []
    let defaultItems = MockData.defaultItems
    
    init() {
        todo = defaultItems
    }
    
    func addTodo(title: String, description: String, date: Date) {
        let newTodo = ProjectModel(title: title, description: description, date: date)
        todo.append(newTodo)
    }    
}
