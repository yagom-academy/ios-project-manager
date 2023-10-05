//
//  CloudButton.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

struct CloudButton: View {
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var networkManager: NetworkManager
    
    var body: some View {
        Group {
            if userManager.user != nil && networkManager.isConnected {
                ConnectedButton()
            } else if networkManager.isConnected == false {
                BadNetworkButton()
            } else {
                DisconnectedButton()
            }
        }
    }
}
