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
        let validDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        if task.dueDate < validDate, task.status != .done {
            return dateView
                .foregroundColor(.red)
                .font(.subheadline)
        } else {
            return dateView
                .foregroundColor(.primary)
                .font(.subheadline)
        }
    }
    
    private var dueDate: String {
        viewModel.formatDueDate(of: task)
    }
    
}
