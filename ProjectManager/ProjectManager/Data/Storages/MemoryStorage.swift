//
//  MemoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Storage {
    func read() -> AnyPublisher<[TodoListModel], Never>
    func delete(item: TodoListModel)
}

final class MemoryStorage: Storage {
    @Published var datas: [TodoListModel] = TodoListModel.dummyData()
    
    func read() -> AnyPublisher<[TodoListModel], Never> {
        $datas.eraseToAnyPublisher()
    }
    
    func delete(item: TodoListModel) {
        if let index = datas.firstIndex(of: item) {
            datas.remove(at: index)
        }
    }
}
