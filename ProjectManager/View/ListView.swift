//
//  ListView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/26.
//

import SwiftUI

struct ListView: View {
  @ObservedObject var listViewModel: ListViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      List {
        Section(header: HeaderView(title: listViewModel.taskType.title,
                                   numberOfTasks: listViewModel.readTasks().count)){
          ForEach(listViewModel.readTasks()) { task in
            ListRowView(taskTitle: task.title,
                        taskBody: task.body,
                        taskDate: task.date,
                        isOverdate: task.isOverdate)
            .onTapGesture {
              listViewModel.cellTapped()
            }
            .sheet(isPresented: $listViewModel.isShowingSheet) {
              EditView(editViewModel: EditViewModel(withService: listViewModel.service, task: task))
            }
            .onLongPressGesture(minimumDuration: 1) {
              listViewModel.cellLongPressed()
            }
            .popover(isPresented: $listViewModel.isShowingPopover,
                     arrowEdge: .bottom) {
              PopoverButton(taskType: listViewModel.taskType) { type in
                listViewModel.moveTask(task, type: type)
              }
            }
          }
          .onDelete { index in
            listViewModel.swipedCell(index: index)
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
    ListView(listViewModel: ListViewModel(withService: TaskManagementService(), taskType: .todo))
  }
}
