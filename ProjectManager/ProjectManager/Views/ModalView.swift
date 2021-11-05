//
//  PopoverEdit.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/01.
//

import SwiftUI

struct ModalView: View {
    
    @EnvironmentObject var listViewModel: ProjectManagerViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var date = Date()
    @Binding var isModalPresented: Bool
    
    var body: some View {
        VStack {
                HStack {
                    Button {
                        isModalPresented = false
                    } label: {
                        Text("Cancel")
                            .font(.title3)
                            .padding(.leading)
                    }
                    Spacer()
                    Text("TODO")
                        .font(.title2)
                        .padding(.top)
                    Spacer()
                    Button {
                        addTodoAction()
                        isModalPresented = false
                    } label: {
                        Text("Done")
                            .font(.title3)
                            .padding(.trailing)
                    }
                }
                .padding(.bottom)
                .background(Color(white: 0.93))
    
            VStack {
                TextField("Title", text: $title)
                    .font(.title3)
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 5)
                
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    
                TextEditor(text: $description)
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 5)
            }
            .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
        }
    }
    
    private func addTodoAction() {
        if checkEmptyLabel() {
            listViewModel.addTodo(title: title, description: description, date: date)
        }        
    }
    
    func checkEmptyLabel() -> Bool {
        if title.count == 0 || description.count == 0 {
            return false
        }
            return true
    }
}
