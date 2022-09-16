//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/15.
//

class MainViewModel: DataManagable {
            
    // MARK: - Properties

    private let mockToDoItemManager = MockToDoItemManager()

    private var todoContent: [ToDoItem] {
        didSet {
            todoListener?(todoContent)
        }
    }
    
    private var doingContent: [ToDoItem] {
        didSet {
            doingListener?(doingContent)
        }
    }
    
    private var doneContent: [ToDoItem] {
        didSet {
            doneListener?(doneContent)
        }
    }
    
    private var todoListener: (([ToDoItem]) -> Void)?
    private var doingListener: (([ToDoItem]) -> Void)?
    private var doneListener: (([ToDoItem]) -> Void)?

    // MARK: - Initializers

    init(_ todoContent: [ToDoItem] = [], _ doingContent: [ToDoItem] = [], _ doneContent: [ToDoItem] = []) {
        self.todoContent = todoContent
        self.doingContent = doingContent
        self.doneContent = doneContent
    }

    // MARK: - Functions
    
    func todoSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(todoContent)
        self.todoListener = listener
    }
    
    func doingSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(doingContent)
        self.doingListener = listener
    }
    
    func doneSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(doneContent)
        self.doneListener = listener
    }
    
    func fetchData() {
        let mockItem = mockToDoItemManager.loadData()
        
        todoContent = mockItem.todo
        doingContent = mockItem.doing
        doneContent = mockItem.done
    }
    
    func count(of type: ProjectType) -> Int {
        switch type {
        case .todo:
            return todoContent.count
        case .doing:
            return doingContent.count
        case .done:
            return doneContent.count
        }
    }
    
    func searchContent(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return todoContent.get(index: index) ?? ToDoItem()
        case .doing:
            return doingContent.get(index: index) ?? ToDoItem()
        case .done:
            return doneContent.get(index: index) ?? ToDoItem()
        }
    }
    
    func append(new item: ToDoItem, to type: ProjectType) {
        switch type {
        case .todo:
            todoContent.append(item)
        case .doing:
            doingContent.append(item)
        case .done:
            doneContent.append(item)
        }
    }
    
    func delete(from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            todoContent.remove(at: index)
        case .doing:
            doingContent.remove(at: index)
        case .done:
            doneContent.remove(at: index)
        }
    }
}
