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
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
}

extension DefaultTodoHistoryViewModel: HistoryViewModel {
    var historyList: Observable<[HistoryCellContent]> {
        useCase.readHistoryItems()
            .withUnretained(self)
            .map { (self, items) in
                items.map { item in
                    HistoryCellContent(item: item, dateFormatter: self.dateFormatter)
                }
            }
    }
}
