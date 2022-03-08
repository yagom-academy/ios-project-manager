//
//  ContentView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ProjectManagerViewModel
    
    @State var isShowingAddSheet = false
    
    var body: some View {
        
        NavigationView {
            HStack {
                TaskListView(name: "TODO", taskType: .todo)
                TaskListView(name: "DOING", taskType: .doing)
                TaskListView(name: "DONE", taskType: .done)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowingAddSheet, onDismiss: nil) {
                        TaskDetailView(viewModel: viewModel, isShowingAddSheet: $isShowingAddSheet)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ProjectManagerViewModel()
        ContentView()
            .environmentObject(viewModel)
    }
    
}
