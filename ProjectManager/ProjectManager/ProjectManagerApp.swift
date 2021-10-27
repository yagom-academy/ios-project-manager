//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/26.
//

import SwiftUI
import Firebase

@main
struct TestApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
