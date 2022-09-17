//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

final class TodoListViewModel {
    private let todoDataManager = TodoDataManager()
    private var todoList: [Todo] = []
    private var doingList: [Todo] = []
    private var doneList: [Todo] = []
    
    var todoCount: Int {
        todoList.count
    }
    var doingCount: Int {
        doingList.count
    }
    var doneCount: Int {
        doneList.count
    }
    
    init() {
        read()
        didChangedCount?()
    }
    
    var didChangedCount: (() -> Void)?
    var didCreatedTodo: ((Todo) -> Void)?
    var didEditedTodo: (([Todo]) -> Void)?
    var didMovedTodo: (([[Todo]]) -> Void)?
    
    private func read() {
        todoList = todoDataManager.read(category: Category.todo) ?? []
        doingList = todoDataManager.read(category: Category.doing) ?? []
        doneList = todoDataManager.read(category: Category.done) ?? []
    }
    
    func fetchTodoList(in category: String) -> [Todo] {
        switch category {
        case Category.todo:
            return todoList
        case Category.doing:
            return doingList
        case Category.done:
            return doneList
        default:
            return []
        }
    }
    
    func fetchTodo(in category: String, at index: Int) -> Todo {
        switch category {
        case Category.todo:
            return todoList[index]
        case Category.doing:
            return doingList[index]
        case Category.done:
            return doneList[index]
        default:
            return Todo()
        }
    }
    
    func create(todo: Todo) {
        todoDataManager.create(with: todo)
        read()
        didCreatedTodo?(todo)
        didChangedCount?()
    }
    
    func delete(todo: Todo) {
        todoDataManager.delete(todo)
        read()
        didChangedCount?()
    }
    
    func edit(todo: Todo, with model: Todo) {
        todoDataManager.update(todo: todo, with: model)
        read()
        switch todo.category {
        case Category.todo:
            didEditedTodo?(todoList)
        case Category.doing:
            didEditedTodo?(doingList)
        case Category.done:
            didEditedTodo?(doneList)
        default:
            return
        }
    }
    
    func move(_ selectedTodo: Todo, to target: String ) {
        let todo = Todo()
        todo.title = selectedTodo.title
        todo.body = selectedTodo.body
        todo.date = selectedTodo.date
        todo.category = target
        todoDataManager.update(todo: selectedTodo, with: todo)
        read()
        didMovedTodo?([todoList, doingList, doneList])
        didChangedCount?()
    }
}
