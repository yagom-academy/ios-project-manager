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
    
    var body: some Scene {
        WindowGroup {
            KanbanView(kanbanViewModel: DIContainer.kanbanViewModel)
                .environmentObject(keyboard)                
        }
    }
}
