//
//  FakeToDoItemManager.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import Foundation

final class FakeToDoItemManager: DataManagable {
    // MARK: - Properties
    
    var todoContent: [ToDoItem] = [] {
        didSet {
            todoListener?(todoContent)
        }
    }
    
    var doingContent: [ToDoItem] = [] {
        didSet {
            doingListener?(doingContent)
        }
    }
    
    var doneContent: [ToDoItem] = [] {
        didSet {
            doneListener?(doneContent)
        }
    }
    
    private var todoListener: (([ToDoItem]) -> Void)?
    private var doingListener: (([ToDoItem]) -> Void)?
    private var doneListener: (([ToDoItem]) -> Void)?
    
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
    
    init() {
        read()
    }
    
    // MARK: - CRUD
    
    func read() {
        guard let data: ItemListCategory? = JSONDecoder.decodedJson(jsonName: Design.jsonName),
              let mockItem = data else { return }
        todoContent = mockItem.todo
        doingContent = mockItem.doing
        doneContent = mockItem.done
    }
    
    func read(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return todoContent.get(index: index) ?? ToDoItem()
        case .doing:
            return doingContent.get(index: index) ?? ToDoItem()
        case .done:
            return doneContent.get(index: index) ?? ToDoItem()
        }
    }
    
    func create(with item: ToDoItem, to type: ProjectType) {
        switch type {
        case .todo:
            todoContent.append(item)
        case .doing:
            doingContent.append(item)
        case .done:
            doneContent.append(item)
        }
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            todoContent[index] = item
        case .doing:
            doingContent[index] = item
        case .done:
            doneContent[index] = item
        }
    }
    
    func delete(index: Int, with type: ProjectType) {
        switch type {
        case .todo:
            todoContent.remove(at: index)
        case .doing:
            doingContent.remove(at: index)
        case .done:
            doneContent.remove(at: index)
        }
    }
    
    func count(with type: ProjectType) -> Int {
        switch type {
        case .todo:
            return todoContent.count
        case .doing:
            return doingContent.count
        case .done:
            return doneContent.count
        }
    }
    
    private enum Design {
        static let jsonName = "MockData"
    }
}
