////
////  ListView.swift
////  ProjectManager
////
////  Created by Do Yi Lee on 2021/10/31.
////
//
import SwiftUI

struct EventListView<T: ListRowViewModelable>: View {
    let state: EventState
    var eventListviewModels: T
   // var viewModel: ListRowViewModelable
    
    var body: some View {
        List {
            VStack {
//                ForEach(eventListviewModels.output.events) { event in
//                    EventListRowView(listRowViewModel: viewModel)
//                }.onDelete { indexSet in
//                    indexSet
//                }
            }.listStyle(.insetGrouped)
            
            
        }
    }
}
