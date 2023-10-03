//
//  KanbanView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct KanbanView: View {
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                HStack {
                    ColumnView(tasks: kanbanViewModel.todos, title: "TODO")
                    ColumnView(tasks: kanbanViewModel.doings, title: "DOING")
                    ColumnView(tasks: kanbanViewModel.dones, title: "DONE")
                }
                .background(.quaternary)
                .navigationTitle("Project Manager")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("History") {
                            kanbanViewModel.setHistoryVisible(true)
                        }
                        .popover(isPresented: $kanbanViewModel.isHistoryOn) {
                            HistoryView(superSize: geo.size)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            kanbanViewModel.setFormVisible(true)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .customAlert(isOn: $kanbanViewModel.isFormOn) {
                TaskFormView(TaskCreateViewModel(formSize: geo.size))
            }
            .customAlert(item: $kanbanViewModel.selectedTask) {
                TaskFormView(
                    TaskEditViewModel(
                        task: kanbanViewModel.selectedTask ?? Task(),
                        formSize: geo.size
                    )
                )
            }
        }
        .environmentObject(kanbanViewModel)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct KanbanView_Previews: PreviewProvider {
    @StateObject static private var kanbanViewModel = KanbanViewModel.mock
    static var previews: some View {
        KanbanView()
            .environmentObject(kanbanViewModel)
    }
}
