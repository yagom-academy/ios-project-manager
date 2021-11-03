//
//  ToDoListHeaderView.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct ToDoListHeaderView: View {
    @EnvironmentObject var todoList: TodoViewModel
    var todoState: TodoState
    var body: some View {
        HStack {
            Text(todoState.description)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            ZStack{
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                Text("\(todoList.countTodoCell(state: todoState))")
                    .foregroundColor(.white)
                    .font(.body)
            }
        }
    }
}

struct ToDoListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListHeaderView(todoState: .todo)
    }
}
