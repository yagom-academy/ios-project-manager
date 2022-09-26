//
//  ContentView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/06.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainViewModel = MainViewModel()
    @EnvironmentObject var dataManager: DataManager
    
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
                TodoContentView(todo: nil, buttonType: "Done", index: nil, showingSheet: mainViewModel.showingSheet)
            })
        }
        .onAppear {
            dataManager.add(title: "33", body: "3333", date: Date(), status: .todo)
            dataManager.add(title: "444", body: "4444", date: Date(), status: .done)
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
