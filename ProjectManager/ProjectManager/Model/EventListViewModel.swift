////
////  EventListViewModel.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/11/04.
////
//
//import Foundation
//
//
//protocol EventListViewModelInputInterface {
//    func onDeleteRow()
//}
//
////protocol EventListViewModelOutputInterface {
////    var event: [Event] { get }
////}
//
//protocol EventListViewModelable: ObservableObject {
//    var input: EventListViewModelInputInterface { get }
//   // var output: EventListViewModelOutputInterface { get }
//}
//
//class EventListViewModel: EventListViewModelable {
//    var input: EventListViewModelInputInterface { return self }
//   // var output: EventListViewModelOutputInterface { return self }
//
//    @Published var events: [Event]
//    
//    init(event: Event) {
//        self.events = [event]
//    }
//}
//
//extension EventListViewModel: EventListViewModelInputInterface {
//    func onDeleteRow() {
//        //
//    }
//    
// 
//}
//
//extension EventListViewModel: EventListViewModelOutputInterface {
//
//}
