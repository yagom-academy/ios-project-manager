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

struct HistoryCellContent {
    let title: String
    let createAt: String
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    init(item: History) {
        switch item.changes {
        case .moved:
            title = "\(item.changes.rawValue) '\(item.title)' from \(item.beforeState?.rawValue ?? "") to \(item.afterState?.rawValue ?? "")"
        case .added:
            title = "\(item.changes.rawValue) '\(item.title)'"
        case .removed:
            title = "\(item.changes.rawValue) '\(item.title)' from \(item.beforeState?.rawValue ?? "")"
        }
        
        self.createAt = item.createAt.toString(dateFormatter)
    }
}
