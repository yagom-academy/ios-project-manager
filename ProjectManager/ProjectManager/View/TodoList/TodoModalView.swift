//
//  TodoModalView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/11/02.
//

import SwiftUI

struct TodoModalView: View {
    enum Purpose {
        case add
        case show
        case edit
    }
    @EnvironmentObject private var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State var viewPurpose: Purpose
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
            .disabled(viewPurpose == .show)
            .shadow(radius: 10)
            .padding(.horizontal)
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    leadingButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingButton
                        .disabled($todo.title.wrappedValue.isEmpty)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private var leadingButton: some View {
        return Button(
            action: viewPurpose == .show ? { viewPurpose = .edit } : { isPresented.toggle() },
            label: { Text(viewPurpose == .show ? "Edit" : "Cancel") }
        )
    }
    
    private var trailingButton: some View {
        return Button(
            action: doneButtonAction,
            label: { Text("Done") }
        )
    }
}

extension TodoModalView {
    private func doneButtonAction() {
        switch viewPurpose {
        case .add:
            viewModel.addItem(todo)
        case .show :
            break
        case .edit:
            viewModel.editItem(todo)
        }
        isPresented.toggle()
    }
}

struct TodoModalView_Previews: PreviewProvider {
    @State static var showingDetail = false
    
    static var previews: some View {
        TodoModalView(isPresented: $showingDetail, viewPurpose: .add, todo: Todo())
            .previewLayout(.sizeThatFits)
    }
}
