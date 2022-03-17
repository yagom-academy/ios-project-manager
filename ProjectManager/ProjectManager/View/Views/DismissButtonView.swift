//
//  DismissButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DismissButtonView: View {
    @Binding var show: Bool
    
    var body: some View {
        Button {
            self.show = false
        } label: {
            Text("Cancel")
        }
    }
}
