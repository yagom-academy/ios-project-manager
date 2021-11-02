//
//  ToDoListViewModel.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/02.
//

import Foundation

enum Action  {
    case create(todo: Todo)
    case onAppear
}

final class ToDoListViewModel: ObservableObject{
    @Published private(set) var toDoList: [Todo] = []

    func action(_ action: Action) {
        switch action {
        case .create(let todo):
            toDoList.append(todo)
        case .onAppear:
            print("asdasd")
        }
    }
    func fetchList(type: SortType) -> [Todo] {
        return toDoList.filter {
            $0.type == type
        }
    }

    func todoCount(type: SortType) -> String {
        return toDoList.filter { $0.type == type }.count.description
    }
}
