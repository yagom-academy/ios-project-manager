//
//  ContentView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(todoTasks: DummyData.dummyData)

                TodoListView(todoTasks: DummyData.dummyData)

                TodoListView(todoTasks: DummyData.dummyData)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
