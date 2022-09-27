//
//  RegisterView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/15.
//

import SwiftUI

struct TodoContentView: View {
    
    @EnvironmentObject private var dataManager: TodoDataManager
    @StateObject private var todoContentViewModel: TodoContentViewModel
    
    init(todo: Todo?, buttonType: String, index: Int?, showingSheet: Binding<Bool>) {
        _todoContentViewModel = StateObject(wrappedValue: TodoContentViewModel(todo: todo, buttonType: buttonType, index: index, showingSheet: showingSheet))
    }
    
    var body: some View {
        NavigationView {
            RegisterElementsView(todoContentViewModel: todoContentViewModel)
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(.systemGray5)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            todoContentViewModel.showingSheet.toggle()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            todoContentViewModel.manageTask(dataManager: dataManager)
                        }, label: {
                            Text(todoContentViewModel.buttonType)
                        })
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
    
}

struct RegisterElementsView: View {
    @ObservedObject var todoContentViewModel: TodoContentViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("제목", text: $todoContentViewModel.title)
                .padding(.all)
                .background(
                    Color(UIColor.systemBackground)
                        .shadow(color: Color.primary.opacity(0.4), radius: 5, x: 0, y: 5)
                )
                .border(.gray)
                .padding(.leading)
                .padding(.trailing)
                .font(.title2)
            
            DatePicker("", selection: $todoContentViewModel.date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
            ZStack(alignment: .topLeading) {
                Group {
                    TextEditor(text: $todoContentViewModel.body)
                    Text("내용을 입력하세요.")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 8)
                        .opacity(todoContentViewModel.body.isEmpty ? 1 : 0)
                }
            }
            .border(.gray)
            .background(
                Color(UIColor.systemBackground)
                    .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 0, y: 5)
            )
            .padding(.all, 10)
        }
    }
}
