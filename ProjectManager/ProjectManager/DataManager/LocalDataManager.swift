//
//  LocalDataManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/30.
//

import RealmSwift

protocol RemoteRepositoryConnectable: AnyObject {
    func add(todo: Todo)
    func read(_ completion: @escaping ([Todo]) -> Void)
    func delete(todo: Todo)
    func update(todo: Todo, with model: TodoModel)
    func move(todo: Todo, to target: String)
}

final class LocalDataManager {
    weak var delegate: RemoteRepositoryConnectable?
    private let realm = try! Realm()
    
    private func setupLocalData(with todo: [Todo]) {
        todo.forEach {
            setupLocalTodo(with: $0)
        }
    }
    
    private func setupLocalTodo(with todo: Todo) {
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func synchronizeData(_ completion: @escaping () -> Void) {
        delegate?.read { [weak self] remoteData in
            self?.compareData(with: remoteData) {
                completion()
            }
        }
    }
    
    private func compareData(with remoteData: [Todo], _ completion: @escaping () -> Void) {
        let localData = realm.objects(Todo.self)
        if localData.count != remoteData.count {
            deleteAllLocalData()
            setupLocalData(with: remoteData)
        }
        completion()
    }
    
    func create(with todo: Todo) {
        delegate?.add(todo: todo)
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(category: String) -> [Todo] {
        let savedList = realm.objects(Todo.self)
        switch category {
        case Category.todo:
            return Array(savedList.filter("category == 'TODO'")
                .sorted { $0.date < $1.date })
        case Category.doing:
            return Array(savedList.filter("category == 'DOING'")
                .sorted { $0.date < $1.date })
        case Category.done:
            return Array(savedList.filter("category == 'DONE'")
                .sorted { $0.date < $1.date })
        default:
            return []
        }
    }

    func update(todo: Todo, with model: TodoModel) {
        delegate?.update(todo: todo, with: model)
        do {
            try realm.write {
                todo.title = model.title
                todo.body = model.body
                todo.date = model.date
                todo.category = model.category
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func move(todo: Todo, to target: String) {
        delegate?.move(todo: todo, to: target)
        do {
            try realm.write {
                todo.category = target
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ todo: Todo) {
        delegate?.delete(todo: todo)
        do {
            try realm.write {
                realm.delete(todo)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllLocalData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
