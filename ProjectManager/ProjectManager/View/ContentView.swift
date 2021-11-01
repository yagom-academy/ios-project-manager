//
//  ContentView.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationView {
            HStack {
                TodoListView()
                TodoListView()
                TodoListView()
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $isPresented) {
                        NewTodoView()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
