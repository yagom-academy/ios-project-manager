//
//  MainView.swift
//  ProjectManager
//
//  Created by Do Yi Lee on 2021/10/31.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ProjectEventsManager
    
    var body: some View {
        NavigationView {
            HStack {
                VStack {
                    Section(header: Text("ToDo")
                                .font(.title)) {
                    }
                    EventListView(state: .ToDo)
                        .listStyle(.grouped)
                        .environmentObject(viewModel)
                }
                
                VStack {
                    Section(header: Text("Doing")
                                .font(.title)) {
                    }
                    EventListView(state: .Doing)
                        .listStyle(.grouped)
                        .environmentObject(viewModel)
                }
                
                VStack {
                    Section(header: Text("Done")
                                .font(.title)) {
                    }
                    EventListView(state: .Done)
                        .listStyle(.grouped)
                        .environmentObject(viewModel)
                    }
            }
            .navigationBarTitle("프로젝트 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                AddEventButton()
                    .environmentObject(self.viewModel)
            })
        }.navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ProjectEventsManager())
    }
}
