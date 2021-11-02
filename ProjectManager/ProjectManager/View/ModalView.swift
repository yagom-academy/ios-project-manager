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
    var modalViewType: ModalType = .add
    
    var customButton: some View {
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
                    Button {
                       isDone = false
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    customButton
                    }
                }
            }
        .onDisappear {
            todoListViewModel.action(.create(todo: Todo(title: title, description: description, date: date, type: .toDo)))
        }
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isDone: .constant(false))
    }
}
