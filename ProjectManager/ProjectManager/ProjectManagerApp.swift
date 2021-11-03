//
//  ProjectManagerApp.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/02.


import SwiftUI

@main
struct ProjectManagerApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(listViewModel)
        }
        
    }
}
