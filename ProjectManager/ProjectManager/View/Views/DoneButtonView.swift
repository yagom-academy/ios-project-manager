//
//  DoneButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DoneButtonView: View {
    @Binding var show: Bool
    @Binding var title: String
    @Binding var content: String
    @Binding var limitDate: Date
    
    @ObservedObject var viewModel: ProjectManagerViewModel
    
    var body: some View {
        Button {
            self.viewModel.createTask(title: title, content: content, limitDate: limitDate)
            self.show = false
        } label: {
            Text("Done")
        }
    }
}
