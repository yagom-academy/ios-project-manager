//
//  EditButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/09.
//

import SwiftUI

struct EditButtonView: View {
    @Binding var show: Bool
    
    var body: some View {
        Button {
            self.show = true
        } label: {
            Text("Edit")
        }
    }
}
