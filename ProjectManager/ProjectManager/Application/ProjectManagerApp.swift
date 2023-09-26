//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/19.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
