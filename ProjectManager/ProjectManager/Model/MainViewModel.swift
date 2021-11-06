//
//  Model.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import Foundation
import SwiftUI

enum EventState: String {
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

//protocol MainViewModelInputInterface {
//    func OnFetchEvents(type: EventState) -> [Event]
//    func OnRequestCreate(newEvent: Event)
////    func OnRequestRead(eventId: UUID,
////                       completionHandler: @escaping (Event?) -> ())
////    func OnRequestUpdate(event: Event)
////    func OnRequestDelete(targetEvent: Event)
//}
//
//protocol MainViewModelOutputInterface {
//    var listViewModel: EventListViewModel { get }
//    var events: [EventState: EventListViewModel] { get }
//}
//
//protocol MainViewModelable: ObservableObject {
//    var input: MainViewModelInputInterface { get }
//    var output: MainViewModelOutputInterface { get }
//}
//
//class ProjectManager: MainViewModelable {
//    var output: MainViewModelOutputInterface { return self }
//    var input: MainViewModelInputInterface { return self }
//
//    @Published var events: [EventState: [Event]]
//
//    init(isOnTest: Bool) {
//        if isOnTest {
//            self.events = [ .ToDo : [Event(title: "제목을 써주세요",
//                                           description: "자세한 설명을 추가 해 볼까요?",
//                                           date: Date(),
//                                           id: UUID())],
//                            .Doing : [Event(title: "제목을 써주세요",
//                                            description: "자세한 설명을 추가 해 볼까요?",
//                                            date: Date(),
//                                            id: UUID())],
//                            .Done : [Event(title: "제목을 써주세요",
//                                           description: "자세한 설명을 추가 해 볼까요?",
//                                           date: Date(),
//                                           id: UUID())]
//
//            ]
//        } else {
//            self.events = [.ToDo: [], .Doing: [], .Done: []]
//        }
//
//    }
//}
//
//extension ProjectManager: MainViewModelInputInterface {
//    func OnFetchEvents(type: EventState) -> [Event] {
//        return self.events[type] ?? []
//    }
//
//    func OnRequestCreate(newEvent: Event) {
//        self.events[.ToDo]?.append(newEvent)
//    }
    
//    func OnRequestRead(eventId: UUID, completionHandler: @escaping (Event?) -> ()) {
//        for event in events {
//            for i in 0...event.value.count - 1 {
//                if event.value[i].id == eventId {
//                    completionHandler(event.value[i])
//                }
//            }
//        }
//    }
//
//    func OnRequestUpdate(event: Event) {
//        OnRequestRead(eventId: event.id) { targetEvent in
//            guard var targetEvent = targetEvent else {
//                return
//            }
//           targetEvent = event
//        }
//    }
//
//    func OnRequestDelete(targetEvent: Event) {
//        OnRequestRead(eventId: targetEvent.id) { event in
//            var event = event
//            event = nil
//        }
//    }
//}
//
//
//extension ProjectManager: MainViewModelOutputInterface {
//    
//}
