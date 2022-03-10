//
//  TaskFormDescriptionEditorView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskFormDescriptionEditorView: View {
    
    @Binding var description: String
    
    var body: some View {
        TextEditor(text: $description)
            .shadow(radius: 5)
    }
    
}
