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

struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
        AllListView(allListViewModel: AllListViewModel(withService: TaskManagementService()))
    }
}
