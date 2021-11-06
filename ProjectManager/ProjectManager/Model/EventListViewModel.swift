////
////  EventListViewModel.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/11/04.
////
//
import Foundation


protocol EventListViewModelInputInterface {
    func onDeleteRow()
}

protocol EventListViewModelOutputInterface {
    var events: [Event] { get }
}

protocol EventListViewModelable: ObservableObject {
    var input: EventListViewModelInputInterface { get }
    var output: EventListViewModelOutputInterface { get }
}

class EventListViewModel: EventListViewModelable {
    var input: EventListViewModelInputInterface { return self }
    var output: EventListViewModelOutputInterface { return self }

    @Published var events: [Event]
    
    init(isTestView: Bool) {
        if isTestView {
            self.events = [Event(title: "a", description: "a", date: Date(), state: .ToDo, id: UUID())]
            return
        }
        self.events = [Event]()
    }
}

extension EventListViewModel: EventListViewModelInputInterface {
    func onDeleteRow() {
        //
    }
}

extension EventListViewModel: EventListViewModelOutputInterface {
}
