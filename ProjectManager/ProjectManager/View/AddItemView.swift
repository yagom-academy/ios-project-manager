//
//  AddItemView.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button {
                    viewModel.isPresented.toggle()
                } label: {
                    TodoListTextButton(text: "Cancel")
                }
                Spacer()
                Text("TODO")
                Spacer()
                Button {
                    viewModel.create()
                    viewModel.addCount(count: &viewModel.todoCount)
                    viewModel.isPresented.toggle()
                } label: {
                    TodoListTextButton(text: "Done")
                }
            }
            .padding()
            TodoListTitleTextField()
                .frame(height: 50)
                .padding()
            TodoListDatePicker(text: "날짜를 입력하세요.")
            TodoListDescTextField()
                .padding()
        }
    }
}
