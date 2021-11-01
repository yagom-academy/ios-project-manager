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
   // var output: Output { get }
}

//MARK: -ViewModel
class ProjectLists: ObservableObject, ViewModelAble {
    @Published private(set) var manager: EventManager = EventManager()
    
    var jobs: [Event] {
        return self.manager.lists
    }
    
    var input: Input = Input(titleText: "",
                             descriptionText: "",
                             dateText: Date(),
                             state: .ToDo)
   // @Published var output: Output
    
    func create() {
        let emptyString = ""
        
        let newEvent = Event(title: input.titleText,
                             description: input.descriptionText,
                                date: input.dateText,
                                state: input.state)
        self.manager.create(list: newEvent)
        self.input = Input(titleText: emptyString,
                           descriptionText: emptyString,
                           dateText: Date(),
                           state: .ToDo)
    }
    struct Input {
        var titleText: String
        var descriptionText: String
        var dateText: Date
        var state: ListState
    }
}



struct Output {
    var isOutDated: Bool
}
