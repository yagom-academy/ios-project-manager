//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    var title: String
    @Binding var todoTasks: [Todo]
    
    var body: some View {
        VStack {
            titleHeaderView(title: title, taskCount: $todoTasks.count)
            List {
                ForEach(todoTasks) { task in
                    TodoListRow(todo: task)
                }
                .onDelete { index in
                    todoTasks.remove(atOffsets: index)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.systemGray6))
        Divider()
    }
    
    private func titleHeaderView(title: String, taskCount: Int) -> some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.largeTitle)
            Text("\(taskCount)")
                .font(.title3)
                .frame(width: 28.5, height: 24)
                .padding(.all, 3)
                .colorInvert()
                .background(Color.primary)
                .clipShape(Circle())
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: -1, trailing: 0))
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(title: "TODO", todoTasks: .constant(DummyData.dummyData))
            .previewInterfaceOrientation(.landscapeRight)
    }
}
