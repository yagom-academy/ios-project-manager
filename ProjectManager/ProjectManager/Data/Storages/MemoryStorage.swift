//
//  MemoryStorage.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation
import Combine

protocol Storage {
    func create(_ item: TodoListModel)
    func read() -> AnyPublisher<[TodoListModel], Never>
    func update(_ item: TodoListModel)
    func delete(_ item: TodoListModel)
}

final class MemoryStorage: Storage {
    @Published var datas: [TodoListModel] = TodoListModel.dummyData()
    
    func create(_ item: TodoListModel) {
        datas.append(item)
    }
    
    func read() -> AnyPublisher<[TodoListModel], Never> {
        $datas.eraseToAnyPublisher()
    }
    
    func update(_ item: TodoListModel) {
        if let targetIndex = datas.firstIndex(where: { $0.id == item.id }) {
            datas[targetIndex] = item
        }
    }
    
    func delete(_ item: TodoListModel) {
        if let index = datas.firstIndex(of: item) {
            datas.remove(at: index)
        }
    }
}
