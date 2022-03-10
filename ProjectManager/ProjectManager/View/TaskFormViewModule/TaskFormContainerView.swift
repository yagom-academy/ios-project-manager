//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskFormContainerView: View {
    
    @Binding var title: String
    @Binding var date: Date
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            TaskFormTitleFieldView(title: $title)
            dueDatePicker
            descriptionEditor
        }
    }
    
    private var dueDatePicker: some View {
        DatePicker(
            "",
            selection: $date,
            displayedComponents: [.date]
        )
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
    
    private var descriptionEditor: some View {
        TextEditor(text: $description)
            .shadow(radius: 5)
    }
    
}
