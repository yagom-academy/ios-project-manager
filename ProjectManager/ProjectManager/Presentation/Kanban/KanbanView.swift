//
//  KanbanView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct KanbanView: View {
    @EnvironmentObject private var taskManager: TaskManager
    @EnvironmentObject private var historyManager: HistoryManager
    @EnvironmentObject private var userManager: UserManager
    
    @StateObject private var kanbanViewModel = KanbanViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                HStack {
                    ColumnView(tasks: taskManager.todos, title: "TODO")
                    ColumnView(tasks: taskManager.doings, title: "DOING")
                    ColumnView(tasks: taskManager.dones, title: "DONE")
                }
                .background(.quaternary)
                .navigationTitle("Project Manager")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("History") {
                            historyManager.setHistoryVisible(true)
                        }
                        .popover(isPresented: $historyManager.isHistoryOn) {
                            HistoryView(superSize: geo.size)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        CloudButton()
                        
                        Button {
                            kanbanViewModel.setFormVisible(true)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .alert("클라우드에 데이터를 안전하게 보관하세요", isPresented: $userManager.isRegisterFormOn) {
                RegisterView()
            } message: {
                Text("이전에 등록한 이메일이 있다면 입력 후 복원하세요")
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .environmentObject(kanbanViewModel)
    }
}

struct KanbanView_Previews: PreviewProvider {
    @StateObject static private var taskManager = TaskManager.mock
    static var previews: some View {
        KanbanView()
            .environmentObject(taskManager)
    }
}
