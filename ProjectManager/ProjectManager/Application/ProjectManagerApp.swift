//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct ProjectManagerApp: App {
    
    @StateObject private var keyboard = DIContainer.keyboard
    @StateObject private var kanbanViewModel = DIContainer.kanbanViewModel
    @StateObject private var historyViewModel = DIContainer.historyViewModel    
    @StateObject private var loginViewModel = DIContainer.loginViewModel
    
    var body: some Scene {
        WindowGroup {
            KanbanView()
                .environmentObject(keyboard)
                .environmentObject(kanbanViewModel)
                .environmentObject(historyViewModel)
                .environmentObject(loginViewModel)
        }
    }
}
