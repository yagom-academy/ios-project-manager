//
//  AllListView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/20.
//

import SwiftUI

struct AllListView: View {
    @ObservedObject var allListViewModel: AllListViewModel
    
    var body: some View {
        HStack {
            // TODO
            ListView(listViewModel: ListViewModel(withService: allListViewModel.service),
                     taskType: TaskType.todo,
                     numberOfTasks: allListViewModel.showLists().filter({ $0.type == .todo }).count)
            
            // DOING
            ListView(listViewModel: ListViewModel(withService: allListViewModel.service),
                     taskType: TaskType.doing,
                     numberOfTasks: allListViewModel.showLists().filter({ $0.type == .doing }).count)
            
            // DONE
            ListView(listViewModel: ListViewModel(withService: allListViewModel.service),
                     taskType: TaskType.done,
                     numberOfTasks: allListViewModel.showLists().filter({ $0.type == .done }).count)
        }
    }
}

private struct ListView: View {
    @ObservedObject var listViewModel: ListViewModel
    let taskType: TaskType
    let numberOfTasks: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: HeaderView(title: taskType.title, numberOfTasks: numberOfTasks)){
                    ForEach(listViewModel.service.readTasks().filter({ $0.type == taskType })) { task in
                        ListRowView(task: task)
                            .onTapGesture {
                                listViewModel.toggleShowingSheet()
                            }
                            .sheet(isPresented: $listViewModel.isShowingSheet) {
                                EditView(editViewModel: EditViewModel(withService: listViewModel.service),
                                         task: task)
                            }
                            .onLongPressGesture(minimumDuration: 1) {
                                listViewModel.toggleShowingPopover()
                            }
                            .popover(isPresented: $listViewModel.isShowingPopover,
                                     arrowEdge: .bottom) {
                                PopoverButton(taskType: taskType) { to in
                                    listViewModel.moveTask(task, to: to)
                                }
                            }
                    }
                    .onDelete { offset in
                        //                        tasks.remove(atOffsets: offset)
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
        AllListView(allListViewModel: AllListViewModel(withService: TaskManagementService()))
    }
}
