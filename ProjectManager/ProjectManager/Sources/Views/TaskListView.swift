//
//  TaskListView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var taskDashboardViewModel = TaskDashboardViewModel()
    
    var statusForQuery: Status
    var tasks: [Task] {
        switch statusForQuery {
        case .todo:
            return taskDashboardViewModel.todo
        case .doing:
            return taskDashboardViewModel.doing
        case .done:
            return taskDashboardViewModel.done
        }
    }
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                ZStack {
                    TaskCellView(task: task)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .listRowSeparator(.hidden)
                //TODO: 높이가 description의 높이에 따라 유동적으로 변하도록 수정 (최대 3줄)
                //FIXME: List 사이의 공간이 하얗게 보이는 문제 발생
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TaskListView(statusForQuery: .todo)
        }
    }
}
