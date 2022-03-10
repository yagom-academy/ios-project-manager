//
//  TaskListTitleView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListTitleView: View {
    
    let taskType: TaskStatus
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    var body: some View {
        HStack {
            Text(taskTitle)
                .font(.largeTitle)
                .padding(.leading)
            
            Text(taskCount)
                .font(.headline)
                .colorInvert()
                .padding(10)
                .background(Circle())
        }
    }
    
    private var tasks: [Task] {
        viewModel.findTasks(of: taskType)
    }
    
    private var taskCount: String {
        String(tasks.count)
    }
    
    private var taskTitle: String {
        taskType.description
    }
    
}
