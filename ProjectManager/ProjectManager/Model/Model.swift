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

struct EventManager {
    private(set) var events: [Event]
    
    mutating func create(list: Event) {
        self.events.append(list)
    }
    
    func read(_ id: UUID) -> Event? {
        let event = self.events.filter { event in
            event.id == id
        }.first
        
        return event
    }
    
    private func find(list: Event) -> Int? {
        for index in 0...self.events.count - 1 {
            if self.events[index].id == list.id {
                return index
            }
        }
        return nil
    }
    
    mutating func update(list: Event) {
        let targetEventIndex = find(list: list)
        self.events[targetEventIndex ?? .zero] = list
    }
    
    mutating func delete(list: Event) {
        guard let index = find(list: list) else {
            return
        }
        self.events.remove(at: index)
    }
   
    init() {
        self.events = [Event(title: "제목을 써주세요",
                          description: "자세한 설명을 추가 해 볼까요?",
                          date: Date(),
                          state: .ToDo)]
    }
}
