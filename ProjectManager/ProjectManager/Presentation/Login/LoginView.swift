//
//  LoginView.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    var body: some View {
        Group{
            TextField("이메일을 입력하세요", text: $loginViewModel.inputEmail)
            Button("나중에"){}
            Button("시작하기"){
                loginViewModel.register()
                kanbanViewModel.fetchAll()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
