//
//  TaskEditView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskEditView: View {
    @Binding var title: String
    @Binding var content: String
    @Binding var limitDate: Date
    
    var body: some View {
        titleTextField
        limitDatePicker
        contentEditor
    }
    
    var titleTextField: some View {
        TextField("Title", text: $title)
            .textFieldStyle(.roundedBorder)
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
