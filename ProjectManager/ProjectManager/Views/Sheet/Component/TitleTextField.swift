//
//  TitleTextField.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct TitleTextField: View {
    @Binding var content: String
    
    var body: some View {
        Rectangle()
            .frame(height: 50)
            .foregroundColor(.white)
            .shadow(radius: 5, x: 0, y: 5)
            .overlay(
                TextField("Title", text: $content)
                    .padding(20)
            )
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}

struct TitleTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextField(content: .constant(MemoManager().memos[0].title))
    }
}
