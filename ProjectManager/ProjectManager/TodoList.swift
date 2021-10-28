//
//  TodoList.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject private var todoViewModel: TodoViewModel
    var completionState: Todo.Completion
    
    var body: some View {
        List {
            Section(
                content: {
                    TodoRow()
                },
                header: {
                    HStack {
                        Text(completionState.description)
                            .font(.title)
                            .foregroundColor(.black)
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.black)
                            Text("1")
                                .foregroundColor(.white)
                        }
                        .font(.title2)
                    }
                }
            )
        }
        .listStyle(.grouped)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(completionState: .done)
            .environmentObject(TodoViewModel())
    }
}
