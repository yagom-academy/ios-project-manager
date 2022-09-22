//
//  ContentView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/06.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(todoTasks: DummyData.dummyData)

                TodoListView(todoTasks: DummyData.dummyData)

                TodoListView(todoTasks: DummyData.dummyData)
            }
            .navigationTitle("Project Manager")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .background(Color(UIColor.systemGray3))
            .sheet(isPresented: $showingSheet, content: {
                TodoContentView(buttonType: "Done")
            })
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
