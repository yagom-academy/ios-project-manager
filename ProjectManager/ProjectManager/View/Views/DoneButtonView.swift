//
//  DoneButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DoneButtonView: View {
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    @Binding var show: Bool
    @Binding var title: String
    @Binding var content: String
    @Binding var limitDate: Date
    
    var body: some View {
        Button {
            self.viewModel.createTask(title: title, content: content, limitDate: limitDate)
            self.show = false
        } label: {
            Text("Done")
        }
    }
}
