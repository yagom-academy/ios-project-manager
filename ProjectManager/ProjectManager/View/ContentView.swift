//
//  ContentView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @State private var isShowingSheet = false
    
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
                        isShowingSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowingSheet, onDismiss: nil) {
                        TaskCreateView(isShowingSheet: $isShowingSheet)
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
