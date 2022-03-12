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
        Text(dueDate)
            .foregroundColor(foregroundColor)
            .font(.subheadline)
    }
    
    private var taskValidCondition: Bool {
        viewModel.isValid(task: task)
    }
    
    private var foregroundColor: Color {
        taskValidCondition ? .red : .primary
    }
    
    private var dueDate: String {
        viewModel.formatDueDate(of: task)
    }
    
}
