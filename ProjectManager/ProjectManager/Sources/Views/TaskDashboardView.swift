//
//  TaskDashboardView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskDashboardView: View {
    
    var body: some View {
        HStack {
            TaskListView(statusForQuery: .todo)
            TaskListView(statusForQuery: .doing)
            TaskListView(statusForQuery: .done)
        }
    }
}

struct TaskDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDashboardView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
