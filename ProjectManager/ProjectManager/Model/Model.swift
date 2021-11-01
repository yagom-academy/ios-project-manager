//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation

//MARK: -Model
enum ListState {
    case ToDo
    case Doing
    case Done
}

struct Event: Identifiable {
    var title: String
    var description: String
    var date: Date
    var state: ListState
    var id = UUID()
}

enum EventError: Error {
    case noEvent
}

struct EventManager {
    private(set) var lists: [Event]
    
    mutating func create(list: Event) {
        self.lists.append(list)
    }
    
    func read(list: Event) -> Result<Event, EventError> {
        guard let index = find(list: list) else {
            return .failure(.noEvent)
        }
        return .success(self.lists[index])
    }
    
    private func find(list: Event) -> Int? {
        for index in 0...self.lists.count - 1 {
            if self.lists[index].id == list.id {
                return index
            }
        }
        return nil
    }
    
    mutating func update(list: Event) {
        let targetEvent = read(list: list)
        
        switch targetEvent {
        case .failure(let error):
            print(error)
        case .success(var event):
            event = list
        }
    }
    
    mutating func delete(list: Event) {
        guard let index = find(list: list) else {
            return
        }
        self.lists.remove(at: index)
    }
   
    init() {
        self.lists = [Event(title: "제목을 써주세요",
                          description: "자세한 설명을 추가 해 볼까요?",
                          date: Date(),
                          state: .ToDo)]
    }
}
