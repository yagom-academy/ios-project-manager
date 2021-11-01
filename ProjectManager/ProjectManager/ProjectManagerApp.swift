//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/26.
//

import SwiftUI
import Firebase

@main
struct ProjectManagerApp: App {
    
    @StateObject private var viewModel = TaskViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
