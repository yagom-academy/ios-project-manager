//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import SwiftUI

struct TaskListView: View {
    @State var taskStatus : Status
    @ObservedObject var viewModel: TaskListViewModel
    
    var body: some View {
        List{
            Section(header: Text(taskStatus.rawValue).font(.title3).foregroundColor(.black)) {
                ForEach(viewModel.selectTaskList(through: taskStatus), id: \.self) { task in
                    RowView(viewModel: viewModel, task: task)
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(taskStatus: .TODO, viewModel: TaskListViewModel(dataManager: MockData())).previewInterfaceOrientation(.landscapeRight)

    }
}
