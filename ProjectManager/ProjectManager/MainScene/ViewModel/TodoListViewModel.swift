//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class TodoListViewModel {
    weak var coordinator: AppCoordinator?
    
    private var todoList: [TodoModel] = []
    private var doingList: [TodoModel] = []
    private var doneList: [TodoModel] = []
    
    var didCreatedItem: ((TodoModel) -> Void)?
    var didDeletedItem: ((TodoModel) -> Void)?
    var didUpdateItem: ((TodoModel) -> Void)?
    
    // MARK: - Initializer
    init(models: [TodoModel]) {
        self.todoList = models.filter { $0.category == .todo }
        self.doingList = models.filter { $0.category == .doing }
        self.doneList = models.filter { $0.category == .done }
    }
    
    // MARK: - View Transition
    func goToEdit(_ model: TodoModel) {
        coordinator?.goToEdit(model)
    }
    
    func goToCreate() {
        coordinator?.goToCreate()
    }
    
    func showPopover<T: ListCollectionView>(
        at cell: UICollectionViewCell,
        in view: T,
        location: CGPoint,
        indexPath: IndexPath) {
            switch view.category {
            case .todo:
                coordinator?.showPopover(
                    at: cell,
                    in: view,
                    location: location,
                    item: read(.todo)?[indexPath.row]
                )
            case .doing:
                coordinator?.showPopover(
                    at: cell,
                    in: view,
                    location: location,
                    item: read(.doing)?[indexPath.row]
                )
            case .done:
                coordinator?.showPopover(
                    at: cell,
                    in: view,
                    location: location,
                    item: read(.done)?[indexPath.row]
                )
            case .none:
                return
            }
        }
    // MARK: - CRUD
    func create(with model: TodoModel) {
        let category = model.category
        switch category {
        case .todo:
            todoList.append(model)
        case .doing:
            doingList.append(model)
        case .done:
            doneList.append(model)
        }
        didCreatedItem?(model)
    }
    
    func read(_ category: Category?) -> [TodoModel]? {
        switch category {
        case .todo:
            return todoList
        case .doing:
            return doingList
        case .done:
            return doneList
        case .none:
            return nil
        }
    }
    
    func update(model previousModel: TodoModel, to afterModel: TodoModel ) {
        let category = previousModel.category
        switch category {
        case .todo:
            guard let index = todoList.firstIndex(of: previousModel) else { return }
            todoList[index].title = afterModel.title
            todoList[index].body = afterModel.body
            todoList[index].date = afterModel.date
        case .doing:
            guard let index = doingList.firstIndex(of: previousModel) else { return }
            doingList[index].title = afterModel.title
            doingList[index].body = afterModel.body
            doingList[index].date = afterModel.date
        case .done:
            guard let index = doneList.firstIndex(of: previousModel) else { return }
            doneList[index].title = afterModel.title
            doneList[index].body = afterModel.body
            doneList[index].date = afterModel.date
        }
        didUpdateItem?(previousModel)
    }
    
    func delete(model: TodoModel) {
        let category = model.category
        switch category {
        case .todo:
            guard let index = todoList.firstIndex(of: model) else { return }
            todoList.remove(at: index)
        case .doing:
            guard let index = doingList.firstIndex(of: model) else { return }
            doingList.remove(at: index)
        case .done:
            guard let index = doneList.firstIndex(of: model) else { return }
            doneList.remove(at: index)
        }
        didDeletedItem?(model)
    }
    // MARK: - support method
    func generateHeader(category: Category?) -> Header? {
        switch category {
        case .todo:
            return Header(category: .todo,
                          count: read(.todo)?.count ?? 0)
        case .doing:
            return Header(category: .doing,
                          count: read(.doing)?.count ?? 0)
        case .done:
            return Header(category: .done,
                          count: read(.done)?.count ?? 0)
        case .none:
            return nil
        }
    }
}
