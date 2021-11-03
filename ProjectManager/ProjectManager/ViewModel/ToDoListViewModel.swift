//
//  ToDoListViewModel.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/02.
//

import Foundation

enum Action  {
    case create(todo: Todo)
    case delete(indexSet: IndexSet)
    case update(todo: Todo)
    case changeType(id: UUID, type: SortType)
}

final class ToDoListViewModel: ObservableObject{
    @Published private(set) var toDoList: [Todo] = []

    func action(_ action: Action) {
        switch action {
        case .create(let todo):
            toDoList.append(todo)
        case .delete(let indexSet):
            toDoList.remove(atOffsets: indexSet)
        case .update(let todo):
            toDoList.firstIndex { $0.id == todo.id }.flatMap { toDoList[$0] = todo }
        case .changeType(let id, let type):
            toDoList.firstIndex { $0.id == id }.flatMap { toDoList[$0].type = type }
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
