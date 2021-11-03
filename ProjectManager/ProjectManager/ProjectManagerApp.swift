//
//  ProjectManager.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/10/28.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let viewModel = Project()
    
    var body: some Scene {
        WindowGroup {
            ContentView(projects: viewModel)
    
        }
    }
}
