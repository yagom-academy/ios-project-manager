//
//  ListView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct EventListView<T: ListViewModelable>: View {
    let state: EventState
   @ObservedObject var eventListviewModels: T
    
    var body: some View {
        print("EventListView",#function)
        return List {
            ForEach(eventListviewModels.output.itemViewModels) { event in
                EventListRowView(listRowViewModel: event)
            }.onDelete { indexSet in
                eventListviewModels.input.onDeleteRow(indexSet: indexSet)
            }
        }
    }
}
