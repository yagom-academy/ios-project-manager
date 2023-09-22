//
//  KanbanView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel = KanbanViewModel()
    @State private var showingAddView = false
    
    var body: some View {        
        NavigationView {
            HStack {
                ColumnView(tasks: kanbanViewModel.todos, title: "TODO")
                ColumnView(tasks: kanbanViewModel.doings, title: "DOING")
                ColumnView(tasks: kanbanViewModel.dones, title: "DONE")
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
        .environmentObject(kanbanViewModel)
    }
}

struct KanbanView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanView(kanbanViewModel: KanbanViewModel.mock)
    }
}
