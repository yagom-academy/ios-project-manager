//
//  TaskListRowDateView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListRowDateView: View {
    
    let task: Task
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    var body: some View {
        let dateView = Text(dueDate)
        
        if taskValidCondition {
            return dateView
                .foregroundColor(.red)
                .font(.subheadline)
        } else {
            return dateView
                .foregroundColor(.primary)
                .font(.subheadline)
        }
    }
    
    private var taskValidCondition: Bool {
        viewModel.isValid(task: task)
    }
    
    private var dueDate: String {
        viewModel.formatDueDate(of: task)
    }
    
}
