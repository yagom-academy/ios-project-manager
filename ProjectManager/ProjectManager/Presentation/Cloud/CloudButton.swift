//
//  CloudButton.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

struct CloudButton: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @State private var isConnectedInformationOn: Bool = false
    
    var body: some View {
        Group {
            if loginViewModel.isConnectedRemoteServer {
                Button {
                    isConnectedInformationOn = true
                } label: {
                    Image(systemName: "icloud")
                }
                .popover(isPresented: $isConnectedInformationOn) {
                    VStack(spacing: 10) {
                        HStack {
                            Text(loginViewModel.email)
                                .foregroundColor(.accentColor)
                            Text(" 계정으로 클라우드에 안전하게 보관중입니다.")
                        }
                        
                        Button("로그아웃") {
                            loginViewModel.logout()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    .padding()
                }
            } else {
                Button {
                    loginViewModel.openRegisterAlert()
                } label: {
                    Image(systemName: "icloud.slash")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
