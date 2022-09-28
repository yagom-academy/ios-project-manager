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
    
    private let realm = try! Realm()
    static let shared = TodoDataManager()

    var didChangedData: [(() -> Void)?] = []
    
    private init() {
        readRemoteData()
    }
    
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
    
    // MARK: - CRUD
    func create(with todo: Todo) {
        firebaseManager.add(todo: todo)
        historyManager.addHistory(todo: todo, with: .added)
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
            firebaseManager.read()
        }
    }
    
    func update(todo: Todo, with model: Todo) {
        firebaseManager.update(todo: todo, with: model)
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
        firebaseManager.move(todo: todo, to: target)
        historyManager.addHistory(todo: todo,
                                  moveTarget: target,
                                  with: .moved)
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
        firebaseManager.delete(todo: todo)
        historyManager.addHistory(todo: todo,
                                  with: .removed)
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
