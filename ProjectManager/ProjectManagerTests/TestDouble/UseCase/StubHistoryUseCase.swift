//
//  StubHistoryUseCase.swift
//  ProjectManagerTests
//
//  Created by 김도연 on 2022/07/20.
//

import Foundation
import Combine

@testable import ProjectManager

final class StubTodoHistoryUseCase: TodoHistoryUseCaseable {
    var items = CurrentValueSubject<[TodoHistory], Never>([])
    
    func create(_ item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        items.send(items.value + [item])
        
        return Empty().eraseToAnyPublisher()
    }
    
    func todoHistoriesPublisher() -> CurrentValueSubject<[TodoHistory], Never> {
        return items
    }
    
    func delete(item: TodoHistory) -> AnyPublisher<Void, StorageError> {
        var itemList = items.value
        itemList.removeAll(where: {$0.id == item.id})
        
        items.send(itemList)
        
        return Empty().eraseToAnyPublisher()
    }
}
