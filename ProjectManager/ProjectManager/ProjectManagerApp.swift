//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by Seoyeon Hong on 2023/05/16.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
