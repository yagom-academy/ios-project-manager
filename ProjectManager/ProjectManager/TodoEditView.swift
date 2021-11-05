//
//  Todo.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

enum EditState {
    case add(Bool)
    case revise(Int, Bool)
}

struct TodoEditView: View {
    @State var editState: EditState
    var body: some View {
        VStack {
            ToDoEditBar(editState: $editState)
            ToDoEditText(editState: $editState)
        }
    }
}

struct ToDoEditBar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var todoList: TodoViewModel
    @Binding var editState: EditState
    var body: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
            }
            Spacer()
            Text("ToDo")
            Spacer()
            Button {
                switch editState {
                case .add:
                    editState = .add(true)
                    presentationMode.wrappedValue.dismiss()
                case .revise(let index, let isRevised):
                    if isRevised {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        editState = .revise(index, true)
                    }
                }
            } label: {
                switch editState {
                case .add:
                    Text("Done")
                case .revise(_, let isRevised):
                    if isRevised {
                        Text("Done")
                    } else {
                        Text("Edit")
                    }
                }
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
    @Binding var editState: EditState
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
        .onAppear {
            switch editState {
            case .revise(let index, _):
                let memo = todoList.memoList[index]
                title = memo.title
                date = memo.date
                description = memo.description
            default:
                break
            }
        }
        .onDisappear {
            switch editState {
            case .add(let isAdded):
                if isAdded {
                    todoList.create(todo: Memo(title: title, description: description, date: date, state: .todo))
                }
            case .revise(let index, let isRevised):
                if isRevised {
                    todoList.update(at: index, todo: Memo(title: title, description: description, date: date, state: .todo))
                }
            }
        }
    }
}

struct TodoEditView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditView(editState: .add(false))
    }
}
