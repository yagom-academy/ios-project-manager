//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/03.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var todo: [ProjectModel] = []
    @Published var doing: [ProjectModel] = []
    @Published var done: [ProjectModel] = []
    
    init() {
        todo = defaultItems()
    }
    
    func defaultItems() -> [ProjectModel] {
        let todo1 = ProjectModel(
            title: "이터널스 보러가기",
            description: "용산 4d로 보고싶다",
            date: Date(timeIntervalSinceNow: 100000000000))
        let todo2 = ProjectModel(
            title: "듄 또 보고싶다",
            description: "용산 아이맥스로 보고싶다",
            date: Date(timeIntervalSinceNow: -10000000000))
        let todo3 = ProjectModel(
            title: "제주도 놀러가기",
            description: "제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.제주도 한달살기 해보고싶다.",
            date: Date(timeIntervalSinceNow: 0))
        
        return [todo1, todo2, todo3]
    }
    
    func deleteTask(at offsets: IndexSet) {
        todo.remove(atOffsets: offsets)
    }
    
    func addTodo(title: String, description: String, date: Date) {
        let newTodo = ProjectModel(title: title, description: description, date: date)
        todo.append(newTodo)
    }    
}
