//
//  AddTodoView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/11/02.
//

import SwiftUI

struct TodoModalView: View {
    enum TodoModal {
        case add
        case edit
    }
    @EnvironmentObject private var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State var modalType: TodoModal
    @State var todo: Todo
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todo.title)
                    .textFieldStyle(.roundedBorder)
                DatePicker("", selection: $todo.endDate, displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .fixedSize()
                TextEditor(text: $todo.detail)
                    .padding(.bottom)
            }
            .shadow(radius: 10)
            .padding(.horizontal)
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    switch modalType {
                    case .add:
                        Button(
                            action: { isPresented.toggle() },
                            label: { Text("Cancel") }
                        )
                    case .edit:
                        Button(
                            action: editButtonAction,
                            label: { Text("Edit") }
                        )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: doneButtonAction,
                        label: { Text("Done") }
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension TodoModalView {
    private func editButtonAction() {
        viewModel.editItem(todo)
        isPresented.toggle()
    }
    
    private func doneButtonAction() {
        switch modalType {
        case .add:
            guard !todo.title.isEmpty, !todo.detail.isEmpty else {
                return
            }
            viewModel.addItem(todo)
        case .edit:
            print("확인완료")
        }
        isPresented.toggle()
    }
}

struct AddTodoView_Previews: PreviewProvider {
    @State static var showingDetail = false
    
    static var previews: some View {
        TodoModalView(isPresented: $showingDetail, modalType: .add, todo: Todo())
            .previewLayout(.sizeThatFits)
    }
}
