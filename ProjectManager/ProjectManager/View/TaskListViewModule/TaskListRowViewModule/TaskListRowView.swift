//
//  TaskRowView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/06.
//

import SwiftUI

struct TaskListRowView: View {
    
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            TaskListRowTitleView(task: task)
            TaskListRowDescriptionView(task: task)
            TaskListRowDateView(task: task)
        }
    }
    
}
