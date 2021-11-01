//
//  Todo.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoEditView: View {
    var body: some View {
        VStack {
            ToDoEditBar()
        }
    }
}

struct ToDoEditBar: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Text("Cancel")
            }
            Spacer()
            Text("ToDo")
            Spacer()
            Button {
                
            } label: {
                Text("Done")
            }
        }
        .padding()
        .background(Color.gray)
    }
}

struct TodoEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView()
    }
}
