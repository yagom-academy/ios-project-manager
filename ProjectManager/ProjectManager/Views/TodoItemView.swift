//
//  TodoItemRow.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/01.
//

import SwiftUI

struct TodoItemView: View {
    
    let todo: TodoViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .lineLimit(1)
                    .font(.title)
                    .foregroundColor(.primary)
            
                Text(todo.description)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                    .padding(EdgeInsets(top: 1, leading: 0, bottom: 3, trailing: 0))
                
                Text(todo.dueDate)
                    .foregroundColor(todo.isExpired ? .red : .black)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}

struct TodoItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todo: TodoViewModel.init(todo: Todo(title: "책상정리",
                                                         description: "집중이 안될 땐 역시나 책상정리",
                                                         dueDate: Date(year: 2021, month: 12, day: 5)!,
                                                         status: .todo)))
            .previewLayout(.fixed(width: 500, height: 300))
    }
}
