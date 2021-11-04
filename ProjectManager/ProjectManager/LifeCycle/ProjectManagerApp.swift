//
//  step2App.swift
//  step2
//
//  Created by yun on 2021/11/03.
//

import SwiftUI

@main
struct ProjectManagerApp: App {
    let object = TodoListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(object)
        }
    }
}
