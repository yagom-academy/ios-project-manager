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
    //output
    @Published private(set) var toDoList: [Todo] = []
    
    func fetchList(type: SortType) -> [Todo] {
        return toDoList.filter {
            $0.type == type
        }
    }
    func action(_ action: Action) {
        switch action {
        case .create(let todo):
            //                toDoList.append(
            //                    Todo(title: todo.title,
            //                        description: todo.description,
            //                        date: todo.date,
            //                        type: .toDo))
            toDoList.append(todo)
        case .onAppear:
            print("asdasd")
        }
    }
    //Input
    //사용자의 입력
    //    viewmodel.action(.create)
    //    viewmodel.action(.delete)
    //    func action(_ action: Action) {
    //        switch action {
    //        case .create:
    //            //실행~ 만들어줘
    //            //toDoList.append(model)
    //        case .onAppear:
    //            // 실행
    //            // 화면 로드될때 뭘 해줄거니?
    //        case didTapCell:
    //        case delete:
    //
    //        }
    //    }
}
