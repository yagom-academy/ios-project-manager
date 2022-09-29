//
//  TaskDescriptionView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/28.
//

import SwiftUI

struct TaskDescriptionView: View {
    
    @Binding var description: String
    
    var body: some View {
        
        TextEditor(text: $description)
            .onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
    }
}

