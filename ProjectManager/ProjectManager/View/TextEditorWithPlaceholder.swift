//
//  TextEditorWithPlaceholder.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/16.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    
    @Binding var taskBody: String
    private let taskBodyPlaceholder: String = "입력 가능한 글자수는 1,000자로 제한합니다."
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $taskBody)
            Text(taskBodyPlaceholder)
                .foregroundColor(.secondary)
                .padding(.horizontal, 6)
                .padding(.vertical, 8)
                .opacity(taskBody.isEmpty ? 1 : 0)
        }
        .font(.title2)
        .padding(.all, 10)
        .border(.gray, width: 1)
    }
}
