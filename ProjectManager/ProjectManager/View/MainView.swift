//
//  ContentView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/06.
//

import SwiftUI

struct MainView: View {
    @State private var showingSheet = false
    @StateObject var viewModel = MainViewModel(data: DummyData.dummyData)
    
    var body: some View {
        NavigationView {
            HStack {
                TodoListView(title: "TODO", todoTasks: $viewModel.todo)

                TodoListView(title: "DOING", todoTasks: $viewModel.doing)

                TodoListView(title: "DONE", todoTasks: $viewModel.done)
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
                TodoContentView(todo: nil, buttonType: "Done", index: nil)
            })
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
