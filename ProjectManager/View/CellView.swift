//
//  CellView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import SwiftUI

struct CellView: View {
    var contentViewModel: ContentViewModel
    var cellIndex: Int
    var taskType: TaskType
    
    @State private var showSheet = false
    @State var isShowingPopover = false
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            if taskType == .todo {
                ListRowView(taskArray: contentViewModel.todoTasks, cellIndex: cellIndex)
            }
            if taskType == .doing {
                ListRowView(taskArray: contentViewModel.doingTasks, cellIndex: cellIndex)
            }
            if taskType == .done {
                ListRowView(taskArray: contentViewModel.doneTasks, cellIndex: cellIndex)
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            isShowingPopover.toggle()
        }
        .popover(isPresented: $isShowingPopover,
                 arrowEdge: .bottom) {
            PopoverButton(contentViewModel: contentViewModel,
                          taskType: taskType,
                          cellIndex: cellIndex)
        }
                 .sheet(isPresented: $showSheet) {
                     EditView(contentViewModel: contentViewModel, cellIndex: cellIndex)
                 }
    }
}

struct PopoverButton: View {
    var contentViewModel: ContentViewModel
    var taskType: TaskType
    var cellIndex: Int
    
    var body: some View {
        switch taskType {
        case .todo:
            Form {
                Button(action: {
                    contentViewModel.moveData(contentViewModel.todoTasks[cellIndex],
                                              from: taskType,
                                              to: .doing)
                    
                }) {
                    Text("Move to DOING")
                }
                Button(action: {
                    contentViewModel.moveData(contentViewModel.todoTasks[cellIndex],
                                              from: taskType,
                                              to: .done)
                    
                }) {
                    Text("Move to DONE")
                }
            }
            .frame(width: 190, height: 90, alignment: .center)
            
        case .doing:
            Form {
                Button(action: {
                    contentViewModel.moveData(contentViewModel.doingTasks[cellIndex],
                                              from: taskType,
                                              to: .todo)
                }) {
                    Text("Move to TODO")
                }
                Button(action: {
                    contentViewModel.moveData(contentViewModel.doingTasks[cellIndex],
                                              from: taskType,
                                              to: .done)
                }) {
                    Text("Move to DONE")
                }
            }
            .frame(width: 190, height: 90, alignment: .center)
            
        case .done:
            Form {
                Button(action: {
                    contentViewModel.moveData(contentViewModel.doneTasks[cellIndex],
                                              from: taskType,
                                              to: .todo)
                }) {
                    Text("Move to TODO")
                }
                Button(action: {
                    contentViewModel.moveData(contentViewModel.doneTasks[cellIndex],
                                              from: taskType,
                                              to: .doing)
                }) {
                    Text("Move to DOING")
                }
            }
            .frame(width: 190, height: 90, alignment: .center)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(contentViewModel: ContentViewModel(), cellIndex: 0, taskType: TaskType.todo)
    }
}
