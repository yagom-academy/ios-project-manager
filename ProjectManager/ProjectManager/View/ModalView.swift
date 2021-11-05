//
//  NewTodoView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct ModalView: View {
    enum ModalType {
        case add
        case edit
    }
    
    @EnvironmentObject var todoListViewModel: ProjectListViewModel
    @Binding var isDone: Bool
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isEdit: Bool = false
    let modalViewType: ModalType
    let currentProject: Project?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                DatePicker("Title",
                           selection: $date,
                           displayedComponents: .date)
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
        .adaptsToKeyboard()
        .onAppear {
            guard let currentProject = currentProject else { return }
            self.title = currentProject.title
            self.date = currentProject.date
            self.description = currentProject.description
        }
    }
}

extension ModalView {
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
                todoListViewModel.action(
                    .create(project: Project(title: title,
                                       description: description,
                                       date: date,
                                       type: .todo)))
            } else if isEdit && modalViewType == .edit,
                      let currentTodo = currentProject {
                todoListViewModel.action(
                    .update(project: Project(id: currentTodo.id,
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
}


struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isDone: .constant(false),
                  modalViewType: .add,
                  currentProject: nil)
    }
}
