//
//  TaskListView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var taskDashboardViewModel = TaskDashboardViewModel()
    
    var body: some View {
        List {
            ForEach(taskDashboardViewModel.tasks) { task in
                ZStack {
                    TaskCellBackgroundView()
                    
                    TaskCellView(task: task)
                        .padding(.leading, 16)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .frame(height: 120)
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
            TaskListView()
        }
    }
}
