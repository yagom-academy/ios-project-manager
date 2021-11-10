//
//  Event.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/11/08.
//

import Foundation

enum EventState: String, CaseIterable {
    case ToDo
    case Doing
    case Done
    
    var popOverButtonOptions: (top: EventState, bottom: EventState) {
        switch self {
        case .ToDo:
            return (.Doing, .Done)
        case .Doing:
            return(.ToDo, .Done)
        case .Done:
            return(.ToDo, .Doing)
        }
    }
}

struct Event: Identifiable {
    var title: String
    var description: String
    var date: Date
    var state: EventState
    var id: UUID
    
    init(title: String, description: String,
         date: Date, state: EventState, id: UUID) {
        self.title = title
        self.description = description
        self.date = date
        self.state = state
        self.id = id
    }
}
