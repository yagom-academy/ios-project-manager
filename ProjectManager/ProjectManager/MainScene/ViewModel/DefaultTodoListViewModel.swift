//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

protocol TodoListViewModelInput {
    func create(todo: Todo)
    func delete(todo: Todo)
    func edit(todo: Todo, with model: Todo)
    func move(_ selectedTodo: Todo, to target: String )
}

protocol TodoListViewModelOutput {
    var todoList: [Todo] { get set }
    var doingList: [Todo] { get set }
    var doneList: [Todo] { get set }
    
    var didChangedCount: [(() -> Void)] { get set }
    var didCreatedTodo: ((Todo) -> Void)? { get set }
    var didEditedTodo: [(([Todo]) -> Void)] { get set }
    var didMovedTodo: [(() -> Void)] { get set }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel: TodoListViewModel {
    private let todoDataManager = TodoDataManager()
    // MARK: - OUTPUT
    var todoList: [Todo] = []
    var doingList: [Todo] = []
    var doneList: [Todo] = []
    
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
        didChangedCount.forEach { $0() }
    }
    
    var didChangedCount: [(() -> Void)] = []
    var didCreatedTodo: ((Todo) -> Void)?
    var didEditedTodo: [(([Todo]) -> Void)] = []
    var didMovedTodo: [(() -> Void)] = []
    
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
    
    // MARK: - INPUT
    func create(todo: Todo) {
        todoDataManager.create(with: todo)
        read()
        didCreatedTodo?(todo)
        didChangedCount.forEach { $0() }
    }
    
    func delete(todo: Todo) {
        todoDataManager.delete(todo)
        read()
        didChangedCount.forEach { $0() }
    }
    
    func edit(todo: Todo, with model: Todo) {
        todoDataManager.update(todo: todo, with: model)
        read()
        switch todo.category {
        case Category.todo:
            didEditedTodo.forEach { $0(todoList) }
        case Category.doing:
            didEditedTodo.forEach { $0(doingList) }
        case Category.done:
            didEditedTodo.forEach { $0(doneList) }
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
        didMovedTodo.forEach { $0() }
        didChangedCount.forEach { $0() }
    }
}
