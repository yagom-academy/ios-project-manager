//
//  TodoDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import Foundation
import RealmSwift

final class TodoDataManager {
    private let realm = try? Realm()
    static let shared = TodoDataManager()
    
    var todoList: Observable<[Todo]> = Observable([])
    var doingList: Observable<[Todo]> = Observable([])
    var doneList: Observable<[Todo]> = Observable([])
    
    private init() {
        read()
    }
    
    // MARK: - CRUD
    func create(with model: Todo) {
        do {
            try realm?.write {
                realm?.add(model)
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
        todoList.value = Array(savedList.filter("category == 'TODO'"))
        doingList.value = Array(savedList.filter("category == 'DOING'"))
        doneList.value = Array(savedList.filter("category == 'DONE'"))
    }
    
    func update(todo: Todo, with model: Todo) {
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
