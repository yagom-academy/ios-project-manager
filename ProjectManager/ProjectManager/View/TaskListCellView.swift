//
//  TaskListCellView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListCellView: View {
    
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(task.title)
                .font(.title3)
                .lineLimit(1)
                .truncationMode(.tail)
            Text(task.body)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3)
                .truncationMode(.tail)
            Text(task.dueDate.dateString)
                .font(.callout)
                .foregroundColor(task.dueDate.isOverdue ? .red : .black)
        }
    }
}
