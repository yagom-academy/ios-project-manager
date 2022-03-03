//
//  TodoList.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

class TodoList {

    private var todoList = [[Todo(title: "기록된 정보가 없습니다", content: TodoListScript.emptyTodo)],
                            [Todo(title: "기록된 정보가 없습니다", content: TodoListScript.emptyDoing)],
                            [Todo(title: "기록된 정보가 없습니다", content: TodoListScript.emptyDone)]]

    @discardableResult
    func remove(at todo: Todo, in section: TodoSection) -> Bool {
        let deleteNoteIndex = self.todoList[section.rawValue].firstIndex { someTodo in
            someTodo.uuid == todo.uuid
        }

        guard let deleteNoteIndex = deleteNoteIndex else {
            return false
        }

        self.todoList.remove(at: deleteNoteIndex)

        return true
    }

    func add(Todo: Todo, in section: TodoSection) {
        var todoListInSection = self.todoList[section.rawValue]

        todoListInSection.append(Todo)

        if todoListInSection.first?.deadline == nil {
            todoListInSection.removeFirst()
        }
    }

    func fetch(completionHandler: @escaping ([[Todo]]) -> Void) {
        completionHandler(self.todoList)
    }
}

private enum TodoListScript {

    static let emptyTodo = "해야할 일을 되돌아봐요"
    static let emptyDoing = "어떤 일을 하고 있나요?"
    static let emptyDone = "이부자리를 정리하고 이곳을 채워볼까요?💪"
}
