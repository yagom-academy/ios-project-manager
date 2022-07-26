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
          ListView(listViewModel: ListViewModel(withService: allListViewModel.service, taskType: .todo))
            // DOING
          ListView(listViewModel: ListViewModel(withService: allListViewModel.service, taskType: .doing))
            // DONE
          ListView(listViewModel: ListViewModel(withService: allListViewModel.service, taskType: .done))
        }
    }
}

struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
        AllListView(allListViewModel: AllListViewModel(withService: TaskManagementService()))
    }
}
