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
        NavigationStack {
            Form {
                Section {
                    TextField("이메일을 입력하세요", text: $userManager.inputEmail)
                } footer: {
                    Text("이전에 등록한 이메일이 있다면 입력 후 복원하세요")
                }                
                
                Section {
                    Button("시작하기"){
                        userManager.register()
                        taskManager.registerFetch()
                    }.disabled(userManager.inputEmail.isEmpty)
                }
            }
            .navigationTitle("클라우드에 데이터를 안전하게 보관하세요")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("나중에") {
                    userManager.pushback()
                }
            }
        }
    }
}
