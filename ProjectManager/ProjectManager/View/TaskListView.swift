//
//  TaskListView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    
    let name: String
    let tasks: [Task]
    
    @State private var isShowingPopover = false
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            taskList
        }
    }
    
    var title: some View {
        Text("\(name) \(tasks.count)")
            .font(.largeTitle)
            .padding()
    }
    
    var taskList: some View {
        List {
            ForEach(tasks) { task in
                Button(action: {
                    self.isShowingPopover.toggle()
                }) {
                    TaskRowView(task: task)
                }.popover(isPresented: $isShowingPopover) {
                    Text("Hello World")
                        .padding()
                }
            }
        }
    }
    
}
