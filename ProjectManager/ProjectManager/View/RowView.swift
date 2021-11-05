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
    @State var clicked: Bool = false
    @State var longPressed: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(task.title).font(.title3)
                Text(task.message)
                Text(DateFormatter.format(date: task.date)).foregroundColor(viewModel.deadlineOver(date: task.date) ? Color.red : Color.black)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            clicked.toggle()
        }.sheet(isPresented: $clicked) {
            ManageTaskView(viewModel: viewModel, title: task.title, date: task.date, message: task.message, task: task)
        }
        .onLongPressGesture {
            longPressed.toggle()

        }.popover(isPresented: $longPressed, attachmentAnchor: .point(.center), arrowEdge: .leading, content: {
            Button {
                viewModel.updateTaskList(task: task, status: .DOING, title: task.title, message: task.message, date: task.date)
            } label: {
                Text("Move to Doing").padding()
            }
            Button {
                viewModel.updateTaskList(task: task, status: .DONE, title: task.title, message: task.message, date: task.date)
            } label: {
                Text("Move to Done").padding()
            }
        })
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    viewModel.delete(task: task)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            }
    }
}

