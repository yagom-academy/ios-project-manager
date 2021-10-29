//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

final class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = [
        Todo(id: 1,
             title: "테스트 1",
             detail: "한줄만 작성되길 바랍니다.",
             endDate: 1635362553,
             completionState: .todo),
        Todo(id: 2,
             title: "테스트 2",
             detail: "두 줄이상 작성이 되겠지? 되어야해,,,그래야해",
             endDate: 1635362553,
             completionState: .done),
        Todo(id: 3,
             title: "테스트 3 이것도 한줄인지 증명하려면 이렇게 적겠지..",
             detail: "본문",
             endDate: 1635362553,
             completionState: .doing),
        Todo(id: 4,
             title: "테스트 4",
             detail: "너는 진짜 3줄이상이 되어야 하는 큰 역할을 가지고 있는 녀석이니까 이렇게 많이 적어도 참아야해. 그래도 모자를까봐 이렇게 많은 문자를 입력하는데 배신하면 안돼",
             endDate: 1640460153,
             completionState: .todo),
        Todo(id: 5,
             title: "테스트 5",
             detail: "본문입니다",
             endDate: 1640460153,
             completionState: .doing)
    ]
    
    func lookForTodoIndex(by id: Int) -> Int? {
        return self.todos.firstIndex(where: { $0.id == id })
    }
}
