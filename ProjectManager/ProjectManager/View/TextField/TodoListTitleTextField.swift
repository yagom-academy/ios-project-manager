//
//  TodoListTitleTextField.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

import SwiftUI

struct TodoListTitleTextField: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                .foregroundColor(.white)
            TextField("Title", text: $viewModel.title)
                .padding()
        }
    }
}

struct TodoListTitleTextField_Previews: PreviewProvider {
    static var previews: some View {
        TodoListTitleTextField()
    }
}

