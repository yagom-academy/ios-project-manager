//
//  ListColumn.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import SwiftUI

struct ListColumn: View {
    
    var tasks: [Task]
    var taskState: TaskState
    
    var body: some View {
        List {
            ListTitle(title: String(describing: taskState),
                      countOfTask: tasks.count.description)
                .listRowInsets(EdgeInsets())
            ForEach(tasks) { task in
                ListRow(task: task)
                    .listRowInsets(EdgeInsets(top: 8,
                                              leading: 0,
                                              bottom: 0,
                                              trailing: 0))
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListColumn(
            tasks: [
                Task(title: "test", description: "descp", date: Date(), state: .doing),
                Task(title: "test", description: "descp", date: Date(), state: .doing),
                Task(title: "test", description: "descp", date: Date(), state: .doing)
            ],
            taskState: TaskState.todo)
    }
}
