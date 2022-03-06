//
//  ContentView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ProjectManagerViewModel
    
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
                    Button(action: { print("add Button Clicked") }) {
                        Image(systemName: "plus")
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

struct TaskRowView: View {
    
    let task: Task
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            Text(task.description)
                .font(.subheadline)
            Text(task.dueDate.description)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ProjectManagerViewModel()
        ContentView(viewModel: viewModel)
    }
    
}
