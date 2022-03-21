//
//  CustomDatePicker.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/18.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var taskDueDate: Date
    private let defaultDatePickerLanguage: String = "en"
    
    var body: some View {
        DatePicker("", selection: $taskDueDate, displayedComponents: .date)
            .labelsHidden()
            .datePickerStyle(.wheel)
            .scaleEffect(1.2)
            .padding(.vertical, 20)
            .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? defaultDatePickerLanguage))
    }
}
