//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

protocol ViewModelAble {
    associatedtype Input
    
    var input: Input { get }
}

struct Output {
    var isOutDated: Bool
}

//MARK: -ViewModel
class ProjectEventsManager: ObservableObject, ViewModelAble {
    struct Input {
        var titleText: String
        var descriptionText: String
        var dateText: Date
        var state: ListState
        var id = UUID()
    }
    
    @Published private(set) var manager: EventManager = EventManager()
    
    var jobs: [Event] {
        return self.manager.events
    }
    
    var input: Input = Input(titleText: "",
                             descriptionText: "",
                             dateText: Date(),
                             state: .ToDo)
    
    func read(_ id: UUID) -> Event? {
        return self.manager.read(id)
    }
    
    func create() {
        let newEvent = Event(title: input.titleText,
                             description: input.descriptionText,
                             date: input.dateText,
                             state: input.state,
                             id: input.id)
        self.manager.create(list: newEvent)
    }
    
    func update() {
        let targetEvent = Event(title: self.input.titleText,
                                description: self.input.descriptionText,
                                date: self.input.dateText,
                                state: self.input.state,
                                id: self.input.id)
        self.manager.update(list: targetEvent)
        self.input = Input(titleText: "",
                           descriptionText: "",
                           dateText: Date(),
                           state: .ToDo)
    }
}
