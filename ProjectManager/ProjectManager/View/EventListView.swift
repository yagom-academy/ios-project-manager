//
//  ListView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct EventListView: View {
    let events: [Event]
    let state: ListState
    
    var body: some View {
        List {
            ForEach(events) { event in
                if event.state == state {
                    EventView(title: event.title,
                              description: event.description,
                              date: "\(event.date)")
                }
            }
        }
    }
}
