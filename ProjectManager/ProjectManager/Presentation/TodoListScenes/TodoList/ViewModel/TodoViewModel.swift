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
    func deleteItem(_ item: Todo)
    func didTapCell(_ item: Todo)
    func didTapFirstContextMenu(_ item: Todo)
    func didTapSecondContextMenu(_ item: Todo)
}

protocol TodoViewModelOutput {
    var items: CurrentValueSubject<[Todo], Never> { get }
    var menuType: MenuType { get }
    var headerTitle: String { get }
}

protocol TodoViewModelable: TodoViewModelInput, TodoViewModelOutput {}

final class TodoViewModel: TodoViewModelable {
    
    private var cancellableBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    let items = CurrentValueSubject<[Todo], Never>([])
    private let state: AnyPublisher<LocalStorageState, Never>
    
    var menuType: MenuType {
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
    
    var headerTitle: String {
        switch processType {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }

    private let processType: ProcessType
    
    weak var delegate: TodoViewModelInput?
    
    init(processType: ProcessType, state: AnyPublisher<LocalStorageState, Never>) {
        self.processType = processType
        self.state = state
        filteredItems(with: processType, state: state)
    }
    
    private func filteredItems(
        with type: ProcessType,
        state: AnyPublisher<LocalStorageState, Never>
    ) {
        state
            .flatMap { state -> AnyPublisher<[Todo], Never> in
                switch state {
                case .success(let items):
                    return Just(items).eraseToAnyPublisher()
                case .failure(let _):
                    return Just([]).eraseToAnyPublisher()
                }
            }
            .sink { [weak self] item in
                let filteredItem = item.filter { $0.processType == type }
                self?.items.send(filteredItem)
            }
            .store(in: &cancellableBag)
        
    }
}

extension TodoViewModel {
    
    // MARK: - Input
    
    func deleteItem(_ item: Todo) {
        delegate?.deleteItem(item)
    }
    
    func didTapCell(_ item: Todo) {
        delegate?.didTapCell(item)
    }
    
    func didTapFirstContextMenu(_ item: Todo) {
        let item = Todo(
            title: item.title,
            content: item.content,
            deadline: item.deadline,
            processType: menuType.firstProcessType,
            id: item.id
        )
        delegate?.didTapFirstContextMenu(item)
    }
    
    func didTapSecondContextMenu(_ item: Todo) {
        let item = Todo(
            title: item.title,
            content: item.content,
            deadline: item.deadline,
            processType: menuType.secondProcessType,
            id: item.id
        )
        delegate?.didTapSecondContextMenu(item)
    }
}
