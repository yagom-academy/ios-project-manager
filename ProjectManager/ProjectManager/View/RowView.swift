//
//  RowView.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State var task: TLTask
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(task.title).font(.title3)
                Text(task.message)
                Text(DateFormatter.format(date: task.date)).foregroundColor(viewModel.deadlineOver(date: task.date) ? Color.red : Color.black)
            }
            Spacer()
        }}
}

