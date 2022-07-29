//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
  @ObservedObject private(set) var listRowViewModel: ListRowViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(listRowViewModel.task.title)
        .foregroundColor(.black)
      Text(listRowViewModel.task.body)
        .foregroundColor(.gray)
      checkOverdate()
    }
    .onTapGesture {
      listRowViewModel.cellTapped()
    }
    .sheet(isPresented: $listRowViewModel.isShowingSheet) {
      EditView(editViewModel: EditViewModel(withService: listRowViewModel.service, task: listRowViewModel.task))
      
    }
    .onLongPressGesture(minimumDuration: 1) {
      listRowViewModel.cellLongPressed()
    }
    .popover(isPresented: $listRowViewModel.isShowingPopover,
             arrowEdge: .bottom) {
      PopoverButton(taskType: listRowViewModel.task.type) { type in
        listRowViewModel.moveButtonTapped(listRowViewModel.task, type: type)
      }
    }
    
  }
  
  private func checkOverdate() -> some View {
    if listRowViewModel.task.isOverdate {
      return Text(listRowViewModel.task.date.convertDateToString)
        .foregroundColor(.red)
    } else {
      return Text(listRowViewModel.task.date.convertDateToString)
        .foregroundColor(.black)
    }
  }
}

struct PopoverButton: View {
  let taskType: TaskType
  let moveButtonTapped: (_ to: TaskType) -> Void
  
  var body: some View {
    Form {
      ForEach(TaskType.allCases.filter{ $0 != taskType }, content: { type in
        Button(action: {
          moveButtonTapped(type)
        }, label: {
          Text("Move to \(type.title)")
        })
      })
    }.frame(width: 200, height: 150, alignment: .center)
  }
}

struct ListRowView_Previews: PreviewProvider {
  static var previews: some View {
    ListRowView(listRowViewModel: ListRowViewModel(withService: TaskManagementService(), task: Task()))
      .previewLayout(.sizeThatFits)
  }
}
