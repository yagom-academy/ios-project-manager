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
            ToDoEditText()
        }
    }
}

struct ToDoEditBar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var todoList: TodoViewModel
    var body: some View {
        HStack {
            Button {
                todoList.isEdited = false
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
            }
            Spacer()
            Text("ToDo")
            Spacer()
            Button {
                todoList.isEdited = true
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
            }
        }
        .padding()
        .background(Color.gray)
    }
}

struct ToDoEditText: View {
    @State private var title = ""
    @State private var date = Date()
    @State private var description = ""
    @EnvironmentObject var todoList: TodoViewModel
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .background(Color.white.shadow(color: .gray, radius: 3, x: 1, y: 4))
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            TextEditor(text: $description)
                .background(Color.white)
                .shadow(color: .gray, radius: 5)
        }
        .onDisappear {
            if todoList.isEdited {
                todoList.create(todo: Memo(title: title, description: description, date: date, state: TodoState.todo))
            }
        }
    }
}

struct TodoEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView()
    }
}
