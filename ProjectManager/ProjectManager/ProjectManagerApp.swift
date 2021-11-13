//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/27.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let todoViewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView(viewModel: todoViewModel)
        }
    }
}
