//
//  ListView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/26.
//

import SwiftUI

struct ListView: View {
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
                        listViewModel.service.tasks.remove(atOffsets: offset)
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct PopoverButton: View {
    let taskType: TaskType
    let moveTask: (_ to: TaskType) -> Void
    
    var body: some View {
        Form {
            ForEach(TaskType.allCases.filter{ $0 != taskType }, content: { type in
                Button(action: {
                    moveTask(type)
                }, label: {
                    Text("Move to \(type.title)")
                })
            })
        }.frame(width: 200, height: 150, alignment: .center)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(listViewModel: ListViewModel(withService: TaskManagementService()), taskType: .todo, numberOfTasks: 1)
    }
}
