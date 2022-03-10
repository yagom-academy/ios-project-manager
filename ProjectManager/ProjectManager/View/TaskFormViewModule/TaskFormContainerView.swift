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
            TaskFormDatePickerView(date: $date)
            TaskFormDescriptionEditorView(description: $description)
        }
    }
    
}
