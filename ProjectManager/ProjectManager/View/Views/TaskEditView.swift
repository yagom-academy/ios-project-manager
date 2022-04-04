//
//  TaskEditView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI
import Combine

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
            .foregroundColor(.black)
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
            .onReceive(Just(content)) { _ in limitText(&content, 100) }
            .shadow(radius: 5)
    }
    
    func limitText(_ stringvar: inout String, _ limit: Int) {
        if stringvar.count > limit {
            stringvar = String(stringvar.prefix(limit))
        }
    }
}
