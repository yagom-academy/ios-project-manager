//
//  ListView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/26.
//

import SwiftUI

struct ListView: View {
  @ObservedObject private(set) var listViewModel: ListViewModel
  
  var body: some View {
    VStack(alignment: .leading) {
      List {
        Section(header: HeaderView(title: listViewModel.taskType.title,
                                   numberOfTasks: listViewModel.filteredTasks.count)){
          ForEach(listViewModel.filteredTasks) { task in
            ListRowView(listRowViewModel: ListRowViewModel(withService: listViewModel.service, task: task))
          }
          .onDelete { index in
            listViewModel.deleteCell(index: index)
          }
        }
      }
      .listStyle(.grouped)
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView(listViewModel: ListViewModel(withService: TaskManagementService(), taskType: .todo))
  }
}
