//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/27.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    @StateObject private var todoViewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(todoViewModel)
        }
    }
}
