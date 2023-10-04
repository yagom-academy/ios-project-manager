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
    @StateObject private var taskManager = DIContainer.taskManager
    @StateObject private var historyManager = DIContainer.historyManager
    @StateObject private var userManager = DIContainer.userManager
    
    var body: some Scene {
        WindowGroup {
            KanbanView()
                .environmentObject(keyboard)
                .environmentObject(taskManager)
                .environmentObject(historyManager)
                .environmentObject(userManager)
        }
    }
}
