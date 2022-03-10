//
//  TaskFormTitleFieldView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskFormTitleFieldView: View {
    
    @Binding var title: String
    
    var body: some View {
        TextField("Title", text: $title)
            .border(.gray)
    }
    
}
