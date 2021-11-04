//
//  TodoListDatePicker.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct TodoListDatePicker: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    var text: String
    
    var body: some View {
        DatePicker(text, selection: $viewModel.date)
            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
    }
}

struct TodoListDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDatePicker(text: "날짜를 입력하세요.")
    }
}
