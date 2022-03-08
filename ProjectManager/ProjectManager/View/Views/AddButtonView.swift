//
//  AddButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var show: Bool
    
    var body: some View {
        Button {
            self.show = true
        } label: {
            Image(systemName: "plus")
        }
    }
}
