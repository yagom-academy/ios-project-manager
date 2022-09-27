//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation
import Combine

final class DataManager: ObservableObject {
    
    @Published var dbManager = TodoDataManager()
    var cancellable: AnyCancellable?
    
    init() {
        self.cancellable = self.dbManager.$todoData.sink(
            receiveValue: { [weak self] _ in
                self?.objectWillChange.send()
            }
        )
    }
    
    func fetch() -> [Todo] {
        self.dbManager.fetch()
    }
    
    func fetch(by status: Status) -> [Todo] {
        self.dbManager.fetch(by: status)
    }
    
    func add(title: String, body: String, date: Date, status: Status) {
        self.dbManager.add(title: title, body: body, date: date, status: status)
    }
    
    func delete(id: UUID) {
        self.dbManager.delete(id: id)
    }
    
    func update(id: UUID, title: String, body: String, date: Date) {
        self.dbManager.update(id: id, title: title, body: body, date: date)
    }
    
    func changeStatus(id: UUID, to status: Status) {
        self.dbManager.changeStatus(id: id, to: status)
    }
    
}
