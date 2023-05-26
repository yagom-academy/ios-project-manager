//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/16.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectMainView()
                .environmentObject(ProjectViewModel())
        }
    }
}
