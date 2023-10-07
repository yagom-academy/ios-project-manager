//
//  DeadlinePicker.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct DeadlinePicker: View {
    @Binding var date: Date
    
    var body: some View {
        DatePicker("deadline", selection: $date, displayedComponents: .date)
            .labelsHidden()
            .datePickerStyle(.wheel)
    }
}

struct DeadlinePicker_Previews: PreviewProvider {
    static var previews: some View {
        DeadlinePicker(date: .constant(MemoViewModel().memos[0].deadline))
    }
}
