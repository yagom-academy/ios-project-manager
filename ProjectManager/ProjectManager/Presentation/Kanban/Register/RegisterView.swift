//
//  RegisterView.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var userManager: UserManager
    @EnvironmentObject private var taskManager: TaskManager
    
    var body: some View {
        Group{
            TextField("이메일을 입력하세요", text: $userManager.inputEmail)
            Button("나중에"){
                userManager.pushback()
            }
            Button("시작하기"){
                userManager.register()
                taskManager.registerFetch()
            }
        }
    }
}
