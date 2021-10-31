//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

protocol ViewModelAble {
    var input: Input? { get }
   // var output: Output { get }
}

//MARK: -ViewModel
class ProjectLists: ViewModelAble, ObservableObject {
    @Published private(set) var manager: EventManager = EventManager()
    
    var jobs: [Event] {
        return self.manager.lists
    }
    
    var input: Input?
   // @Published var output: Output
    
    func create() {
        let emptyString = ""
        guard let input = self.input else {
            return
        }
        
        self.manager.create(list: Event(title: input
                                        .titleText ?? emptyString,
                                        description: input.descriptionText ?? emptyString,
                                        date: input.dateText,
                                        state: input.state))
    }
}

struct Input {
    var titleText: String?
    var descriptionText: String?
    var dateText: Date
    var state: ListState
}

struct Output {
    var isOutDated: Bool
}
