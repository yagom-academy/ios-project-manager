//
//  DoneButtonView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct DoneButtonView: View {
    @Binding var show: Bool
    var action: () -> Void
    
    init(show: Binding<Bool>, action: @escaping () -> Void) {
        self.action = action
        self._show = show
    }
    
    var body: some View {
        Button {
            action()
            show.toggle()
        } label: {
            Text("Done")
        }
    }
}
