//
//  TodoDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import RealmSwift

protocol RemoteRepositoryConnectable: AnyObject {
    func add(todo: Todo)
    func read(_ completion: @escaping (Todo) -> Void)
    func delete(todo: Todo)
    func update(todo: Todo, with model: TodoModel)
    func move(todo: Todo, to target: String)
}

final class TodoDataManager {
    weak var delegate: RemoteRepositoryConnectable?
    private let historyManager = HistoryManager()
    private let undoManager = UndoManager()
    
    private let realm = try! Realm()
    static let shared = TodoDataManager()

    var didChangedData: [(() -> Void)?] = []
    
    private init() {}
    
    func setupInitialData(with todo: Todo) {
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchHistory() -> [History] {
        historyManager.fetchHistories()
    }
    
    // MARK: - UndoManager
    func undo() {
        undoManager.undo()
    }
    
    func redo() {
        undoManager.redo()
    }
    
    func canUndo() -> Bool {
        undoManager.canUndo
    }
    
    func canRedo() -> Bool {
        undoManager.canRedo
    }
    
    // MARK: - CRUD (Realm + FireBase + HistoryManager + UndoManager)
    func create(with todoModel: TodoModel) {
        let todo = Todo(id: UUID(),
                        category: todoModel.category,
                        title: todoModel.title,
                        body: todoModel.body,
                        date: todoModel.date)
        delegate?.add(todo: todo)
        historyManager.addHistory(todo: todo, with: .added)
        undoManager.registerUndo(withTarget: self) { selfType in
            selfType.delete(todo)
        }
        do {
            try realm.write {
                realm.add(todo)
            }
            didChangedData.forEach { $0?() }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(category: String) -> [Todo] {
        let savedList = realm.objects(Todo.self)
        switch category {
        case Category.todo:
            return Array(savedList.filter("category == 'TODO'"))
        case Category.doing:
            return Array(savedList.filter("category == 'DOING'"))
        case Category.done:
            return Array(savedList.filter("category == 'DONE'"))
        default:
            return []
        }
    }
    
    func readRemoteData() {
        let savedList = realm.objects(Todo.self)
        if savedList.isEmpty {
            delegate?.read { [weak self] (todo) in
                self?.setupInitialData(with: todo)
            }
        }
    }
    
    func update(todo: Todo, with model: TodoModel) {
        delegate?.update(todo: todo, with: model)
        let oldModel = TodoModel(category: todo.category,
                                 title: todo.title,
                                 body: todo.body,
                                 date: todo.date)
        undoManager.registerUndo(withTarget: self) { selfType in
            selfType.update(todo: todo, with: oldModel)
        }
        do {
            try realm.write {
                todo.title = model.title
                todo.body = model.body
                todo.date = model.date
                todo.category = model.category
            }
            didChangedData.forEach { $0?() }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func move(todo: Todo, to target: String) {
        delegate?.move(todo: todo, to: target)
        historyManager.addHistory(todo: todo,
                                  moveTarget: target,
                                  with: .moved)
        let oldTarget = todo.category
        undoManager.registerUndo(withTarget: self) { selfType in
            selfType.move(todo: todo, to: oldTarget)
        }
        do {
            try realm.write {
                todo.category = target
            }
            didChangedData.forEach { $0?() }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ todo: Todo) {
        delegate?.delete(todo: todo)
        historyManager.addHistory(todo: todo,
                                  with: .removed)
        let oldTodo = TodoModel(id: todo.id,
                                category: todo.category,
                                title: todo.title,
                                body: todo.body,
                                date: todo.date)
        undoManager.registerUndo(withTarget: self) { selfType in
            selfType.create(with: oldTodo)
        }
        do {
            try realm.write {
                realm.delete(todo)
            }
            didChangedData.forEach { $0?() }
        } catch {
            print(error.localizedDescription)
        }
    }
}
