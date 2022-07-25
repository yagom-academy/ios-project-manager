//
//  TodoHistoryViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RxSwift
import RxRelay

protocol HistoryViewModelOutput {
    var historyList: Observable<[HistoryCellContent]> { get }
}

protocol HistoryViewModel: HistoryViewModelOutput {}

final class DefaultTodoHistoryViewModel {
    private let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
}

extension DefaultTodoHistoryViewModel: HistoryViewModel {
    var historyList: Observable<[HistoryCellContent]> {
        useCase.readHistoryItems()
            .map { items in
                items.map { item in
                    HistoryCellContent(item: item)
                }
            }
    }
}
