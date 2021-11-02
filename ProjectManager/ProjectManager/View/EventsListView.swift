//
//  ListView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct EventListView: View {
    let state: ListState
    @EnvironmentObject var viewModels: ProjectEventsManager
    @State var isPresented = false
    
    var body: some View {
        List {
            ForEach(viewModels.jobs) { event in
                if event.state == state {
                    EventView(title: event.title,
                              description: event.description,
                              date: "\(event.date)")
                        .onTapGesture {
                            isPresented.toggle()
                        }
                        .sheet(isPresented: $isPresented) {
                        } content: {
                            DetailEventView(id: event.id)
                                .environmentObject(viewModels)
                        }
                }
            }
        }
    }
}
