//
//  TodoRowView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct TodoRowView: View {
    var todo: Todo
    @State private var isPresented: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .font(.title3)
                Text(todo.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                Text(DateFormatter.convertDate(date: todo.date) )
                    .foregroundColor(judjedRemainingDate(todo: todo))
                    .font(.footnote)
            }.lineLimit(1)
            Spacer()
        }.contentShape(Rectangle())
            .onTapGesture {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                ModalView(isDone: $isPresented, modalViewType: .edit)
            }
    }
    
    private func judjedRemainingDate(todo: Todo) -> Color? {
        switch todo.type {
        case .toDo, .doing:
            return todo.date > Date() ? Color.red : Color.black
        default:
            return nil
        }
    }
}



struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: Todo(title: "할일",
                               description: "오늘은 설거지를 할게여",
                               date: Date(), type: .toDo))
        //            .previewLayout(.sizeThatFits)
    }
}
