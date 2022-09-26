//
//  TodoListRow.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListRow: View {
    
    let todo: Todo
    @State private var showingSheet = false
    @State var index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(todo.title)
                    .font(.title3)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(todo.body)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Text(todo.date.dateString)
                    .font(.callout)
                    .foregroundColor(todo.date.isOverdue ? .red : .black)
            }
            Spacer()
        }
        .padding(.all, 5)
        .contentShape(Rectangle())
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            TodoContentView(todo: todo, buttonType: "Edit", index: index)
        })
    }
}
