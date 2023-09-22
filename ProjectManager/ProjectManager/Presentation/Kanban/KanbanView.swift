//
//  KanbanView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var vm = KanbanViewModel()
    @State private var showingAddView = false
    
    var body: some View {        
        NavigationView {
            HStack {
                ColumnView(tasks: vm.todos, title: "TODO")
                ColumnView(tasks: vm.doings, title: "DOING")
                ColumnView(tasks: vm.dones, title: "DONE")
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
            TaskFormView(isOn: $showingAddView)
        }
    }
}

struct KanbanView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanView(vm: KanbanViewModel.mock)
    }
}
