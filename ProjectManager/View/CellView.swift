//
//  CellView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import SwiftUI

struct CellView: View {
    @StateObject var cellViewModel: CellViewModel
    var cellIndex: Int
    
    var body: some View {
        Button {
            cellViewModel.toggleShowingSheet()
        } label: {
            switch cellViewModel.task.type {
            case .todo:
                ListRowView(taskArray: cellViewModel.service.tasks,
                            cellIndex: cellIndex,
                            taskType: .todo)
            case .doing:
                ListRowView(taskArray: cellViewModel.service.tasks,
                            cellIndex: cellIndex,
                            taskType: .doing)
            case .done:
                ListRowView(taskArray: cellViewModel.service.tasks,
                            cellIndex: cellIndex,
                            taskType: .done)
            }
        }
        .onLongPressGesture(minimumDuration: 1) {
            cellViewModel.toggleShowingPopover()
        }
        .popover(isPresented: $cellViewModel.isShowingPopover,
                 arrowEdge: .bottom) {
            PopoverButton(popoverButtonViewModel: PopoverButtonViewModel(withService: cellViewModel.service),
                          taskType: cellViewModel.task.type,
                          cellIndex: cellIndex)
        }
                 .sheet(isPresented: $cellViewModel.isShowingSheet) {
                     EditView(editViewModel: EditViewModel(withService: cellViewModel.service),
                              cellIndex: cellIndex)
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

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cellViewModel: CellViewModel(withService: TaskManagementService(), task: Task(title: "", date: Date(), body: "", type: TaskType.todo)), cellIndex: 0)
    }
}
