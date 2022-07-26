//
//  StubTodoUseCase.swift
//  ProjectManagerTests
//
//  Created by 김도연 on 2022/07/20.
//

import Foundation
import Combine
@testable import ProjectManager

final class StubTodoUseCase: TodoListUseCaseable {
    var items = CurrentValueSubject<[Todo], Never>(Todo.dummyData())
    
    func create(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        items.send(items.value + [item])
        
        return Empty().eraseToAnyPublisher()
    }
    
    func todosPublisher() -> CurrentValueSubject<[Todo], Never> {
        return items
    }
    
    func update(_ item: Todo) -> AnyPublisher<Void, StorageError> {
        var itemList = items.value
        
        let targetIndex = itemList.firstIndex(where: {$0.id == item.id})!
        itemList[targetIndex] = item
        
        items.send(itemList)
        
        return Empty().eraseToAnyPublisher()
    }
    
    func delete(item: Todo) -> AnyPublisher<Void, StorageError> {
        var itemList = items.value
        itemList.removeAll(where: {$0.id == item.id})
        
        items.send(itemList)
        
        return Empty().eraseToAnyPublisher()
    }
    
    func synchronizeDatabase() {
        // x
    }
}
