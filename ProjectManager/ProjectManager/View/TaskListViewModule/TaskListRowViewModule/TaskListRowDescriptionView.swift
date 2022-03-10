//
//  TaskListRowDescriptionView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListRowDescriptionView: View {
    
    let task: Task
    
    var body: some View {
        Text(task.description)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(3)
    }
    
}
