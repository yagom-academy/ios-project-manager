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
                            action: {
                                print("Edit 버튼")
                                modalType = .edit
                            },
                            label: { Text("Edit") }
                        )
                    default:
                        Button(
                            action: {
                                print("Cancel 버튼")
                                isPresented.toggle()
                            },
                            label: { Text("Cancel") }
                        )
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            switch modalType {
                            case .add:
                                print("Todo 추가")
                            case .show:
                                print("확인")
                                isPresented.toggle()
                            case .edit:
                                print("수정 완료")
                            }
                        },
                        label: { Text("Done") }
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct AddTodoView_Previews: PreviewProvider {
    @State static var showingDetail = false
    
    static var previews: some View {
        TodoModalView(isPresented: $showingDetail, modalType: .add)
    }
}
