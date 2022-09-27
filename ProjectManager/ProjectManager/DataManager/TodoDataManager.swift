//
//  TodoDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import RealmSwift

final class TodoDataManager {
    private let firebaseManager = RemoteDataManager()
    private let historyManager = HistoryManager()
    
    private let realm = try? Realm()
    static let shared = TodoDataManager()
    
    var todoList: Observable<[Todo]> = Observable([])
    var doingList: Observable<[Todo]> = Observable([])
    var doneList: Observable<[Todo]> = Observable([])
    
    var willDeleteItem: [((Todo) -> Void)?] = []
    var willAppendItem: [((Todo) -> Void)?] = []
    
    private init() {
        read()
    }
    
    func setupInitialData(with todo: Todo) {
        do {
            try realm?.write {
                realm?.add(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
        read()
    }
    
    func fetchHistory() -> [History] {
        historyManager.fetchHistories()
    }
    
    // MARK: - CRUD
    func create(with todo: Todo) {
        willAppendItem.forEach { $0?(todo) }
        
        firebaseManager.add(todo: todo)
        historyManager.addHistory(todo: todo, with: .added)
        do {
            try realm?.write {
                realm?.add(todo)
            }
            read()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(category: String) -> [Todo]? {
        switch category {
        case Category.todo:
            return todoList.value
        case Category.doing:
            return doingList.value
        case Category.done:
            return doneList.value
        default:
            return nil
        }
    }
    
    func read() {
        guard let savedList = realm?.objects(Todo.self) else { return }
        if savedList.isEmpty {
            firebaseManager.read()
        } else {
            todoList.value = Array(savedList.filter("category == 'TODO'"))
            doingList.value = Array(savedList.filter("category == 'DOING'"))
            doneList.value = Array(savedList.filter("category == 'DONE'"))
        }
    }
    
    func update(todo: Todo, with model: Todo) {
        firebaseManager.update(todo: todo, with: model)
        do {
            try realm?.write {
                todo.title = model.title
                todo.body = model.body
                todo.date = model.date
                todo.category = model.category
            }
            read()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func move(todo: Todo, to target: String) {
        historyManager.addHistory(todo: todo,
                                  moveTarget: target,
                                  with: .moved)
        firebaseManager.move(todo: todo, to: target)
        do {
            try realm?.write {
                todo.category = target
            }
            read()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ todo: Todo) {
        willDeleteItem.forEach { $0?(todo) }
        
        historyManager.addHistory(todo: todo,
                                  with: .removed)
        firebaseManager.delete(todo: todo)
        do {
            try realm?.write {
                realm?.delete(todo)
            }
            read()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
            read()
        } catch {
            print(error.localizedDescription)
        }
    }
}
