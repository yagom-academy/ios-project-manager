//
//  TaskListView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskListView: View {
    
    var status: Status
    @Binding var tasks: [Task]
    
    var body: some View {
        VStack {
            TaskListHeaderView(status: status, taskCount: tasks.count)
            
            List {
                ForEach(tasks) { task in
                    ZStack {
                        TaskCellView(task: task)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .listRowSeparator(.hidden)
                    //TODO: 높이가 description의 높이에 따라 유동적으로 변하도록 수정 (최대 3줄)
                    //FIXME: List 사이의 공간이 하얗게 보이는 문제 발생
                }.onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
        }
    }
}
