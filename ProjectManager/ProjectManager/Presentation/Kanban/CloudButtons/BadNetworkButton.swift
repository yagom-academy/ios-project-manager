//
//  BadNetworkButton.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import SwiftUI

struct BadNetworkButton: View {
    @State private var showingPopover: Bool = false
    
    var body: some View {
        Button {
            showingPopover = true
        } label: {
            Image(systemName: "exclamationmark.icloud")
                .tint(.yellow)
        }
        .popover(isPresented: $showingPopover) {
            Text("네트워크가 불안정하여 클라우드 백업이 정지됩니다.")
                .padding()
        }
    }
}

struct BadNetworkButton_Previews: PreviewProvider {
    static var previews: some View {
        BadNetworkButton()
    }
}
