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
        case show
        case edit
    }
    @EnvironmentObject private var todoViewModel: TodoViewModel
    @Binding var isPresented: Bool
    @State var modalType: TodoModal
    @State private var todoTitle: String = ""
    @State private var todoEndDate: Date = Date()
    @State private var todoDetail: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todoTitle)
                    .border(.black)
                DatePicker("", selection: $todoEndDate, displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .fixedSize()
                TextEditor(text: $todoDetail)
                    .border(.black)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    switch modalType {
                    case .show:
                        Button(
                            action: { modalType = .edit },
                            label: { Text("Edit") }
                        )
                    default:
                        Button(
                            action: { isPresented.toggle() },
                            label: { Text("Cancel") }
                        )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            doneButtonAction()
                            isPresented.toggle()
                        },
                        label: { Text("Done") }
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func doneButtonAction() {
        switch modalType {
        case .add:
            let convertedDate = self.todoEndDate.timeIntervalSince1970
            todoViewModel.addTodo(title: self.todoTitle,
                                  endDate: convertedDate,
                                  detail: self.todoDetail)
        case .show:
            print("확인")
        case .edit:
            print("수정 완료")
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    @State static var showingDetail = false
    
    static var previews: some View {
        TodoModalView(isPresented: $showingDetail, modalType: .add)
    }
}
