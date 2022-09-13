//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    
    let todoTasks: [Todo]
    
    var body: some View {
        VStack {
            HeaderView(todoTasks: todoTasks)
            List {
                ForEach(todoTasks) { task in
                    TodoListRow(todo: task)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.systemGray6))
        Divider()
    }
}

struct HeaderView: View {
    
    let todoTasks: [Todo]
    
    var body: some View {
        HStack(spacing: 10) {
            Text("TODO")
                .font(.largeTitle)
                .padding(EdgeInsets(top: 11, leading: 21, bottom: -1, trailing: 0))
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 11, leading: 0, bottom: -1, trailing: 21))
            Spacer()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoTasks: DummyData.dummyData)
        .previewInterfaceOrientation(.landscapeRight)
    }
}
