//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    
    @State var todoTasks: [Todo]
    
    var body: some View {
        VStack {
            HeaderView(todoTasks: todoTasks)
            List {
                ForEach(todoTasks) { task in
                    TodoListRow(todo: task)
                }
                .onDelete { index in
                    print("delete Tapped")
                    todoTasks.remove(atOffsets: index)
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
            Text("\(todoTasks.count)")
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
        TodoListView(todoTasks: DummyData.dummyData)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
