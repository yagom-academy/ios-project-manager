//
//  TodoView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var vm = ViewModel()
    @State private var showingAddView = false
    init(vm: ViewModel = ViewModel()) {
        self.vm = vm
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {        
        NavigationView {
            HStack {
                ListView(tasks: vm.todos, title: "TODO")
                ListView(tasks: vm.doings, title: "DOING")
                ListView(tasks: vm.dones, title: "DONE")
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .customAlert(isOn: $showingAddView) {
         TaskAddView(isOn: $showingAddView)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(
            vm: TodoView.ViewModel(
                todos: TodoView.ViewModel.dummyTodos,
                doings: TodoView.ViewModel.dummyDoings,
                dones: TodoView.ViewModel.dummyDones
            )
        )
    }
}
