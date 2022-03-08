//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    var tasks: [Task]
    var listName: String
    
    var body: some View {
        VStack {
            listTitle
            list
        }
    }
    
    var listTitle: some View {
        HStack {
            Text(listName)
                .font(.title)
        }
    }
    
    var list: some View {
        List(tasks) { task in
            TaskCellView(task: task)
        }
    }
}
