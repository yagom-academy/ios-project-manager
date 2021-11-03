//
//  NewTodoView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

enum ModalType {
    case add
    case edit
}

struct ModalView: View {
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isEdit: Bool = false
    @Binding var isDone: Bool
    @EnvironmentObject var todoListViewModel: ToDoListViewModel
    let modalViewType: ModalType
    var currentTodo: Todo?

    private var customLeadingButton: some View {
        switch modalViewType {
        case .edit:
            return Button {
                isEdit ? (isDone = false): (isEdit = true)
            } label: {
                isEdit ? Text("Cancel"): Text("Edit")
            }
        case .add:
            return Button {
                isDone = false
            } label: {
                Text("Cancel")
            }
        }
    }

    private var customTrailingButton: some View {
        Button {
            if modalViewType == .add {
                todoListViewModel.action(.create(todo: Todo(title: title, description: description, date: date, type: .toDo)))
            } else if isEdit && modalViewType == .edit {
                guard let currentTodo = currentTodo else {
                    return
                }
                todoListViewModel.action(.update(todo: Todo(id: currentTodo.id,
                                                            title: title,
                                                            description: description,
                                                            date: date,
                                                            type: currentTodo.type)))
            }
            isDone = false
        } label: {
            Text("Done")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                DatePicker("Title", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                TextEditor(text: $description)
            }
            .shadow(radius: 5)
            .disabled(modalViewType == .add ? isEdit: !isEdit)
            .padding()
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    customTrailingButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    customLeadingButton
                }
            }
        }

        .onAppear {
            guard let currentTodo = currentTodo else { return }
            self.title = currentTodo.title
            self.date = currentTodo.date
            self.description = currentTodo.description
        }
    }
}

//struct NewTodoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView(isDone: .constant(false))
//    }
//}
