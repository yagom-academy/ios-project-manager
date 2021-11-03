//
//  TodoRowView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct TodoRowView: View {
    @EnvironmentObject var todoListViewModel: ToDoListViewModel
    @State private var isModalViewPresented: Bool = false
    @State private var isLongPressed: Bool = false
    var todo: Todo

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .font(.title3)
                Text(todo.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                Text(DateFormatter.convertDate(date: todo.date))
                    .foregroundColor(judjedRemainingDateColor(todo: todo))
                    .font(.footnote)
            }.lineLimit(1)
            Spacer()
        }.contentShape(Rectangle())
            .onTapGesture {
                isModalViewPresented.toggle()
            }
            .onLongPressGesture {
                isLongPressed.toggle()
            }
            .popover(isPresented: $isLongPressed,
                     attachmentAnchor: .point(.center)) {
                let type = SortType.allCases.filter { $0 != todo.type }
                ForEach(type, id: \.self) {
                    moveButton(type: $0)
                }
            }
            .sheet(isPresented: $isModalViewPresented) {
                ModalView(isDone: $isModalViewPresented,
                          modalViewType: .edit,
                          currentTodo: todo)
            }
    }
}

extension TodoRowView {
    private func moveButton(type: SortType) -> some View {
            ZStack {
                Button {
                    todoListViewModel.action(.changeType(id: todo.id, type: type))
                } label: {
                    Text("Move to \(type.description)")
                }
                .padding()
        }
    }

    private func judjedRemainingDateColor(todo: Todo) -> Color? {
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
                    .previewLayout(.sizeThatFits)
    }
}
