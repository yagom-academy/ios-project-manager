//
//  TaskListRowTitleView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListRowTitleView: View {
    
    let task: Task
    
    var body: some View {
        Text(task.title)
            .font(.headline)
            .foregroundColor(.primary)
            .lineLimit(0)
    }
    
}
