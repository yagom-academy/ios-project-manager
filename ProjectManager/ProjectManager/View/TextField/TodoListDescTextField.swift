//
//  TodoListDescTextField.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct TodoListDescTextField: View {
    @EnvironmentObject var viewModel: TodoListViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                .foregroundColor(.white)
            TextField("Description", text: $viewModel.description)
                .padding()
        }
    }
}

struct TodoListDescTextField_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDescTextField()
    }
}
