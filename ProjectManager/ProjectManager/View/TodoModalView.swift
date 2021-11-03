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
    @EnvironmentObject private var todoViewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State var modalType: TodoModal
    @State private var todoTitle: String = ""
    @State private var todoEndDate: Date = Date()
    @State private var todoDetail: String = ""
    let selectedTodo: Todo?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todoTitle)
                    .textFieldStyle(.roundedBorder)
                DatePicker("", selection: $todoEndDate, displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .fixedSize()
                TextEditor(text: $todoDetail)
                    .padding(.bottom)
            }
            .onAppear(perform: setUpTodo)
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
    private func setUpTodo() {
        guard let todo = selectedTodo else { return }
        
        self.todoTitle = todo.title
        self.todoEndDate = Date(timeIntervalSince1970: todo.endDate)
        self.todoDetail = todo.detail
    }
    
    private func editButtonAction() {
        guard let todo = selectedTodo else { return }
        if !(todo.title == todoTitle &&
             todo.detail == todoDetail &&
             todo.endDate == todoEndDate.timeIntervalSince1970) {
            todoViewModel.editTodo(baseTodo: todo,
                                   title: self.todoTitle,
                                   endDate: self.todoEndDate,
                                   detail: self.todoDetail)
        }
        isPresented.toggle()
    }
    
    private func doneButtonAction() {
        switch modalType {
        case .add:
            guard !self.todoTitle.isEmpty, !self.todoDetail.isEmpty else {
                return
            }
            todoViewModel.addTodo(title: self.todoTitle,
                                  endDate: self.todoEndDate,
                                  detail: self.todoDetail)
        case .edit:
            print("확인완료")
        }
        isPresented.toggle()
    }
}

struct AddTodoView_Previews: PreviewProvider {
    @State static var showingDetail = false
    
    static var previews: some View {
        TodoModalView(isPresented: $showingDetail, modalType: .add, selectedTodo: nil)
            .previewLayout(.sizeThatFits)
    }
}
