//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

enum EventState: String, CaseIterable {
    case ToDo
    case Doing
    case Done
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

protocol MainViewModelInputInterface {
    func onTouchEventCreateButton()
}

protocol MainViewModelOutputInterface {
    var eventListViewModel: EventListViewModel { get }
    var currentEvetDetailViewModel: DetailViewModel? { get }
}

protocol MainViewModelable: ObservableObject {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

class ProjectManager: MainViewModelable {
    var output: MainViewModelOutputInterface { return self }
    var input: MainViewModelInputInterface { return self }

    @Published var eventListViewModel = EventListViewModel()
    
    var currentEvetDetailViewModel: DetailViewModel? {
        self.eventListViewModel.output.itemViewModels.last!.modalViewModel
    }
}

extension ProjectManager: MainViewModelInputInterface {
    func onTouchEventCreateButton() {
        self.eventListViewModel.input.onAddEvent()
    }
}

extension ProjectManager: MainViewModelOutputInterface {
    
}
