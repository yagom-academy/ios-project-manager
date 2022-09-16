//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    
    @State var todoTasks: [Todo]
    @State private var showingSheet = false
    
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
            .onTapGesture {
                showingSheet.toggle()
            }
            .listStyle(.plain)
            .sheet(isPresented: $showingSheet, content: {
                TodoContentView(buttonType: "Edit")
            })
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
                .frame(width: 28.5, height: 24)
                .font(.title3)
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
