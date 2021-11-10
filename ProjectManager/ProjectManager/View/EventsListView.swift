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
        VStack {
            EventListHeader(eventTitle: state.rawValue,
                            eventNumber: "\(eventListViewModels.input.onCountEventNumber(eventState: state))")
            List {
                ForEach(eventListViewModels.output.itemViewModels) { itemViewModel in
                    if itemViewModel.output.currentEvent.state == state {
                        EventListRowView(listRowViewModel: itemViewModel)
                    }
                }.onDelete { indexSet in
                    eventListViewModels.input.onDeleteRow(at: indexSet)
                }
            }
        }
    }
}
