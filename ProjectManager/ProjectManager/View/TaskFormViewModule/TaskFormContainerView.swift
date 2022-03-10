//
//  TaskFormContainerView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskFormContainerView: View {
    
    @ObservedObject var formViewModel: TaskFormViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            TaskFormTitleFieldView(title: $formViewModel.title)
            TaskFormDatePickerView(date: $formViewModel.date)
            TaskFormDescriptionEditorView(description: $formViewModel.description)
        }
    }
    
}
