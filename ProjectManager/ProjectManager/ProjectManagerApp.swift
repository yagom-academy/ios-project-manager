//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by 재재, 언체인 on 2022/09/08.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoListMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
