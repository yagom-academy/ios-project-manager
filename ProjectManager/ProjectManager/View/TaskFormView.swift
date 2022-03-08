//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskFormView: View {
    
    @Binding var title: String
    @Binding var date: Date
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            titleField
            dueDatePicker
            descriptionEditor
        }
    }
    
    var titleField: some View {
        TextField("Title", text: $title)
            .border(.gray)
    }
    
    var dueDatePicker: some View {
        DatePicker(
            "",
            selection: $date,
            displayedComponents: [.date]
        )
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
    
    var descriptionEditor: some View {
        TextEditor(text: $description)
            .shadow(radius: 5)
    }
    
}
