//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = ProjectLists()
    var body: some View {
        HStack {
            ForEach(viewModel.jobs) {
                event in
                if event.state == .ToDo {
                EventView(title: event.title, description: event.description, date: "\(event.date)")
                }
            }
            ForEach(viewModel.jobs) {
                event in
                if event.state == .Doing {
                    EventView(title: event.title, description: event.description, date: "\(event.date)")
                }
            }
            ForEach(viewModel.jobs) {
                event in
                if event.state == .Done {
                EventView(title: event.title, description: event.description, date: "\(event.date)")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
