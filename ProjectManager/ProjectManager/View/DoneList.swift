//
//  DoneList.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct DoneList: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.doneRowItems) { rowItem in
                    TodoListRow(todoListItem: rowItem)
                }.onDelete(perform: viewModel.remove(at:))
            }
            .navigationTitle("DONE     \(viewModel.doneCount)")
        }
        .navigationViewStyle(.stack)
    }
}

struct DoneList_Previews: PreviewProvider {
    static var previews: some View {
        DoneList()
    }
}
