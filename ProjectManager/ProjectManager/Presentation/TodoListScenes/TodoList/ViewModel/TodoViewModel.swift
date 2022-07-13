//
//  TodoViewModel.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/13.
//

import Foundation
import Combine

struct MenuType {
    let firstTitle: String
    let secondTitle: String
    let firstProcessType: ProcessType
    let secondProcessType: ProcessType
}

protocol TodoViewModelInput: AnyObject {
    func deleteItem(_ item: TodoListModel)
    func didTapCell(_ item: TodoListModel)
    func didTapFirstContextMenu(_ item: TodoListModel)
    func didTapSecondContextMenu(_ item: TodoListModel)
}

protocol TodoViewModelOutput {
    var items: AnyPublisher<[TodoListModel], Never> { get set }
    func menuType() -> MenuType
    func headerTitle() -> String
}

protocol TodoViewModelable: TodoViewModelInput, TodoViewModelOutput {}

final class TodoViewModel: TodoViewModelable {
    // MARK: - Output
    
    var items: AnyPublisher<[TodoListModel], Never>

    private let processType: ProcessType
    
    weak var delegate: TodoViewModelInput?
    
    init(processType: ProcessType, items: AnyPublisher<[TodoListModel], Never>) {
        self.processType = processType
        self.items = items
        self.items = filteredItems(with: processType, items: items)
    }
    
    private func filteredItems(
        with type: ProcessType,
        items: AnyPublisher<[TodoListModel], Never>
    ) -> AnyPublisher<[TodoListModel], Never> {
        return items
            .compactMap { item in
                return item.filter { $0.processType == type }
            }
            .eraseToAnyPublisher()
    }
    
    func menuType() -> MenuType {
        switch processType {
        case .todo:
            return MenuType(
                firstTitle: "Move to DOING",
                secondTitle: "Move to DONE",
                firstProcessType: .doing,
                secondProcessType: .done
            )
        case .doing:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DONE",
                firstProcessType: .todo,
                secondProcessType: .done
            )
        case .done:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DOING",
                firstProcessType: .todo,
                secondProcessType: .doing
            )
        }
    }
    
    func headerTitle() -> String {
        switch processType {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}

extension TodoViewModel {
    
    // MARK: - Input
    
    func deleteItem(_ item: TodoListModel) {
        delegate?.deleteItem(item)
    }
    
    func didTapCell(_ item: TodoListModel) {
        delegate?.didTapCell(item)
    }
    
    func didTapFirstContextMenu(_ item: TodoListModel) {
        let item = TodoListModel(
            title: item.title,
            content: item.content,
            deadLine: item.deadLine,
            processType: menuType().firstProcessType,
            id: item.id
        )
        delegate?.didTapFirstContextMenu(item)
    }
    
    func didTapSecondContextMenu(_ item: TodoListModel) {
        let item = TodoListModel(
            title: item.title,
            content: item.content,
            deadLine: item.deadLine,
            processType: menuType().secondProcessType,
            id: item.id
        )
        delegate?.didTapSecondContextMenu(item)
    }
}
