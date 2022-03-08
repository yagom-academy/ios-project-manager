//
//  EditScene.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct EditScene: View {
    var viewModal: ProjectManagerViewModel
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var limitDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                titleTextField
                limitDatePicker
                contentEditor
            }
            .padding()
            .navigationBarTitle("TODO", displayMode: .inline)
        }
    }
    
    var titleTextField: some View {
        TextField("Title", text: $title)
            .border(.gray)
    }
    
    var limitDatePicker: some View {
        DatePicker(
            "",
            selection: $limitDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.wheel)
        .labelsHidden()
    }
    
    var contentEditor: some View {
        TextEditor(text: $content)
            .shadow(radius: 5)
    }
}
