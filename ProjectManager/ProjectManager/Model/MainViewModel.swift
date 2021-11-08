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

class ProjectManager: MainViewModelable, Delegatable {
    func notifyChange() {
        objectWillChange.send()
    }
    
    var output: MainViewModelOutputInterface { return self }
    var input: MainViewModelInputInterface { return self }

    @Published var eventListViewModel = EventListViewModel()
    
    var currentEvetDetailViewModel: DetailViewModel? {
        self.eventListViewModel.output.itemViewModels.last!.detailViewModel
    }
    
    init() {
        self.eventListViewModel.delegate = self
    }
}
extension ProjectManager: MainViewModelInputInterface {
    func onTouchEventCreateButton() {
        self.eventListViewModel.input.onAddEvent()
    }
}

extension ProjectManager: MainViewModelOutputInterface {
    
}
