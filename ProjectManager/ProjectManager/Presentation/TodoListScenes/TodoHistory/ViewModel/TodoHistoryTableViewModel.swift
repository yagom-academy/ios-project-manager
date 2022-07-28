//
//  TodoHistoryTableViewModel.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation
import Combine

protocol TodoHistoryTableViewModelInput {
    // empty
}

protocol TodoHistoryTableViewModelOutput {
    var items: CurrentValueSubject<[TodoHistory], Never> { get }
}

protocol TodoHistoryTableViewModelable: TodoHistoryTableViewModelInput, TodoHistoryTableViewModelOutput {}

final class TodoHistoryTableViewModel: TodoHistoryTableViewModelable {
    
    // MARK: - Output
    
    let items = CurrentValueSubject<[TodoHistory], Never>([])
    
    private let historyUseCase: TodoHistoryUseCaseable
    private var cancellableBag = Set<AnyCancellable>()

    init(historyUseCase: TodoHistoryUseCaseable) {
        self.historyUseCase = historyUseCase
        setData()
    }
    
    private func setData() {
        historyUseCase.todoHistoriesPublisher()
            .flatMap { state -> AnyPublisher<[TodoHistory], Never> in
                switch state {
                case .success(let items):
                    return Just(items).eraseToAnyPublisher()
                case .failure(_):
                    return Just([]).eraseToAnyPublisher()
                }
            }
            .sink { [weak self] items in
                self?.items.send(items)
            }
            .store(in: &cancellableBag)
    }
}
