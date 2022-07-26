//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/05.
//

import SwiftUI
import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct ProjectManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let service = TaskManagementService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: ContentViewModel(withService: service))
        }
    }
}
