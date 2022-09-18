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
    
    // MARK: - CRUD
    func create(with model: Todo) {
        do {
            try realm?.write {
                realm?.add(model)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(category: String) -> [Todo]? {
        guard let savedList = realm?.objects(Todo.self) else { return [] }
        switch category {
        case Category.todo:
            return Array(savedList.filter("category == 'TODO'"))
        case Category.doing:
            return Array(savedList.filter("category == 'DOING'"))
        case Category.done:
            return Array(savedList.filter("category == 'DONE'"))
        default:
            return nil
        }
    }
    
    func readAll() -> Results<Todo>? {
        let savedList = realm?.objects(Todo.self)
        return savedList
    }
    
    func update(todo: Todo, with model: Todo) {
        do {
            try realm?.write {
                todo.title = model.title
                todo.body = model.body
                todo.date = model.date
                todo.category = model.category
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ todo: Todo) {
        do {
            try realm?.write {
                realm?.delete(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
