//
//  BodyTextField.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct BodyTextField: View {
    @Binding var content: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .shadow(radius: 5, x: 0, y: 5)
            .overlay(
                TextEditor(text: $content)
                    .padding(20)
            )
            .padding(10)
    }
}

struct BodyTextField_Previews: PreviewProvider {
    static var previews: some View {
        BodyTextField(content: .constant(MemoViewModel().memos[0].body))
    }
}
