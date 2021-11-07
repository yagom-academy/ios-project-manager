//
//  ListView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct EventListView<T: ListViewModelable>: View {
   @ObservedObject var eventListViewModels: T
    var state: EventState
    
    var body: some View {
        print("EventListView",#function)
        return List {
            ForEach(eventListViewModels.output.itemViewModels) { event in
                if event.output.currentEvent.state == state {
                    EventListRowView(listRowViewModel: event)
                }
            }.onDelete { indexSet in
                eventListViewModels.input.onDeleteRow(at: indexSet)
            }
        }
    }
}
