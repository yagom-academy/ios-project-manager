//
//  TaskFormDatePickerView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskFormDatePickerView: View {
    
    @Binding var date: Date
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
    
}
