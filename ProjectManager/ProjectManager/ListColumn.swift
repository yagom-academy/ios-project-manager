//
//  ListColumn.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import SwiftUI

struct ListColumn: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var taskState: TaskState
    var filteredTasks: [Task] {
        taskViewModel.tasks.filter { task in
            task.state == taskState
        }
    }
    
    var body: some View {
        List {
            ListTitle(title: String(describing: taskState),
                      countOfTask: filteredTasks.count.description)
                .listRowInsets(EdgeInsets(top: 0,
                                          leading: -16,
                                          bottom: 0,
                                          trailing: -16))
            ForEach(filteredTasks) { task in
                ListRow(task: task)
                    .listRowInsets(EdgeInsets(top: 8,
                                              leading: -16,
                                              bottom: 0,
                                              trailing: -16))
            }
        }
        .listStyle(InsetListStyle())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListColumn(
            taskState: TaskState.todo)
            .environmentObject(TaskViewModel())
    }
}
