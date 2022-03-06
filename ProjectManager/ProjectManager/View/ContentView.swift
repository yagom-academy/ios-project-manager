//
//  ContentView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ProjectManagerViewModel
    
    @State var isShowingAddSheet = false
    
    var body: some View {
        
        NavigationView {
            HStack {
                todoList
                doingList
                doneList
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
                    .sheet(isPresented: $isShowingAddSheet,
                           onDismiss: nil) {
                        TaskDetailView(task: nil, isShowingAddSheet: $isShowingAddSheet)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    var todoList: some View {
        List {
            ForEach(viewModel.todoTasks) { task in
                TaskRowView(task: task)
            }
        }
    }
    
    var doingList: some View {
        List {
            ForEach(viewModel.doingTasks) { task in
                TaskRowView(task: task)
            }
        }
    }
    
    var doneList: some View {
        List {
            ForEach(viewModel.doneTasks) { task in
                TaskRowView(task: task)
            }
        }
    }
    
}

struct TaskDetailView: View {
    
    let task: Task?
    
    @State var isEditingMode = false
    @Binding var isShowingAddSheet: Bool
    
    var body: some View {
        
        NavigationView {
            Text("Hello World")
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { isShowingAddSheet.toggle() }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ProjectManagerViewModel()
        ContentView(viewModel: viewModel)
    }
    
}
