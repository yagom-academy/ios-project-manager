//
//  TaskListView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    
    let name: String
    let taskType: TaskStatus
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @State private var isShowingPopover = false
    
    private var tasks: [Task] {
        switch taskType {
        case .todo:
            return viewModel.todoTasks
        case .doing:
            return viewModel.doingTasks
        case .done:
            return viewModel.doneTasks
        }
    }
    
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
                        .contextMenu {
                            ForEach(TaskStatus.allCases) { status in
                                if status != taskType {
                                    Button(action: { viewModel.update(task, taskStatus: status) }) {
                                        Text("Move to \(status.description)")
                                    }
                                }
                            }
                            
                        }
                }
            }
            .onDelete { indexSet in
                viewModel.remove(tasks[indexSet])
            }
        }
        
    }
    
}
