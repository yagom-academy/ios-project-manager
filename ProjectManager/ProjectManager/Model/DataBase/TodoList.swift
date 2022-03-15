//
//  TodoList.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/02.
//

import Foundation

class TodoList {

    private var todoList = [Todo]()

    func remove(at todo: Todo) {
        let deleteNoteIndex = self.todoList.firstIndex { someTodo in
            someTodo.uuid == todo.uuid
        }

        guard let deleteNoteIndex = deleteNoteIndex else {
            return
        }

        self.todoList.remove(at: deleteNoteIndex)
    }

    func add(todo: Todo) {
        self.todoList.append(todo)
        let dummyTodo = self.todoList.filter { someTodo in
            someTodo.task == todo.task && someTodo.deadline == nil
        }

        if let dummy = dummyTodo.first {
            self.remove(at: dummy)
        }
    }

    func edit(todo: Todo, in task: TodoTasks) {
        let beingEditedTodoIndex = self.todoList.firstIndex { someTodo in
            someTodo.uuid == todo.uuid
        }
        var editedTodo = todo
        editedTodo.task = task

        if let index = beingEditedTodoIndex {
            self.todoList[index] = editedTodo
        }
    }

    func fetch(completionHandler: @escaping ([Todo]) -> Void) {
        completionHandler(self.todoList)
    }
}
