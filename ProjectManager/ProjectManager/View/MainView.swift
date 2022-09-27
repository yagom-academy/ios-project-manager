//
//  ContentView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/06.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainViewModel = MainViewModel()
    @EnvironmentObject private var dataManager: TodoDataManager
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(Status.allCases, id: \.self) { status in
                    TodoListView(status: status)
                }
            }
            .navigationTitle("Project Manager")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mainViewModel.showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(.systemGray5)
            .background(Color(UIColor.systemGray3))
            .sheet(isPresented: $mainViewModel.showingSheet, content: {
                TodoContentView(todo: nil, buttonType: "Done", index: nil, showingSheet: $mainViewModel.showingSheet)
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
