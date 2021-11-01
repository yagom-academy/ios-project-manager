//
//  NewTodoView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI

struct NewTodoView: View {
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isEdit: Bool = false
    @State private var isDone: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                DatePicker("Title", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                TextEditor(text: $description)
            }
            .shadow(radius: 5)
            .padding()
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdit.toggle()
                    } label: {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isDone.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView()
    }
}
