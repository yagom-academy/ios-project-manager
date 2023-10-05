//
//  DisconnectedButton.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import SwiftUI

struct DisconnectedButton: View {
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        Button {
            userManager.isRegisterFormOn = true
        } label: {
            Image(systemName: "icloud.slash")
                .foregroundColor(.secondary)
        }
    }
}

struct DisconnectedButton_Previews: PreviewProvider {
    static var previews: some View {
        DisconnectedButton()
    }
}
