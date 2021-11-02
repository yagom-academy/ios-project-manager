//
//  AddTodoView.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/11/02.
//

import SwiftUI

struct TodoModalView: View {
    @State private var todoTitle: String = ""
    @State private var endDate: Date = Date()
    @State private var todoDetail: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $todoTitle)
                    .border(.black)
                DatePicker("", selection: $endDate, displayedComponents: [.date])
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
                    Button(
                        action: {
                            print("Cancel 버튼") },
                        label: {
                            Text("Cancel") }
                    )
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            print("Done 버튼") },
                        label: {
                            Text("Done") }
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoModalView()
    }
}
