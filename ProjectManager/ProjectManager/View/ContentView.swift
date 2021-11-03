//
//  ContentView.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/10/28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var projects: Project
    
    var body: some View {
            NavigationView {
                HStack {
                    ProjectList(projects: projects.todos, status: .todo)
                    ProjectList(projects: projects.doings, status: .doing)
                    ProjectList(projects: projects.dones, status: .done)
                }
                .environmentObject(projects)
                .background(Color(.systemGray4))
                .navigationTitle("Project Manager").font(.title3)
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(projects: Project())
            .previewLayout(.fixed(width: 1136, height: 820))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.verticalSizeClass, .compact)
    }
}
