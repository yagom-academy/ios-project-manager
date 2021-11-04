//
//  DoingList.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct DoingList: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.doingRowItems) { rowItem in
                    TodoListRow(todoListItem: rowItem)
                }.onDelete(perform: viewModel.remove(at:))
            }
            .navigationTitle("DOING     \(viewModel.doingCount)")
        }
        .navigationViewStyle(.stack)
    }
}

struct DoingList_Previews: PreviewProvider {
    static var previews: some View {
        DoingList()
    }
}
