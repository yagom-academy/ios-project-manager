//
//  CustomTextField.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/18.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var taskTitle: String
    private let taskTitlePlaceholder: String = "Title"
    
    var body: some View {
        TextField(taskTitlePlaceholder, text: $taskTitle)
            .font(.title2)
            .padding(.all, 10)
            .background(
                Color(UIColor.systemBackground)
                    .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 0, y: 5)
            )
    }
}
