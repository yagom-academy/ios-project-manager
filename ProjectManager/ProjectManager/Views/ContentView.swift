//
//  ContentView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/10/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todoListVM: TodoListViewModel = {
        let todoListDataStore = TodoListViewModel()
        todoListDataStore.load()
        return todoListDataStore
    }()
    
    var body: some View {
        ProjectManagerView()
            .environmentObject(todoListVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
