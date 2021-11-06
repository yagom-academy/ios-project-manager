////
////  ListView.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/10/31.
////
//
import SwiftUI

//struct EventListView<T: EventListViewModelable>: View {
//    let state: EventState
//    var eventListviewModels: T
//   
//    var body: some View {
//        List {
//            VStack {
//                ForEach(eventListviewModels.output.events[state] ?? []) { event in
//                    EventListItemView(title: event.title,
//                                      description: event.description,
//                                      date: event.date.description)
//                }
//            }.listStyle(.insetGrouped)
//            
//        }
//    }
//}

struct EventListItemView: View {
    var title: String
    var description: String
    var date: String
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
            Text(date)
        }
    }
}

