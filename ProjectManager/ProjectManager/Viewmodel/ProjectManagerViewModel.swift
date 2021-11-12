//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/03.
//

import Foundation

class ProjectManagerViewModel: ObservableObject {
    @Published var list: [[ProjectModel]] = [[],[],[]]
    
    let defaultItems = MockData.defaultItems
    
    init() {
        list[0] = defaultItems
    }
    
    func addTodo(title: String, description: String, date: Date) {
        let newTodo = ProjectModel(title: title, description: description, date: date)
        list[0].append(newTodo)
    }
    
    func deleteItem(offsets: IndexSet) {
        list[0].remove(atOffsets: offsets)
    }
}
