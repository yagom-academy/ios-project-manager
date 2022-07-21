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
            VStack(alignment: .leading) {
                List {
                    Section(header: HeaderView(allListViewModel: allListViewModel, type: .todo)){
                        ForEach(allListViewModel.service.tasks.filter({ $0.type == .todo })) { task in
                            if let index = allListViewModel.service.tasks.firstIndex(of: task) {
                                CellView(cellViewModel: CellViewModel(withService: allListViewModel.service, task: task), cellIndex: index)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.service.tasks.remove(atOffsets: offset)
                        }
                    }
                }
                .listStyle(.grouped)
            }
            
            // DOING
            VStack(alignment: .leading) {
                List {
                    Section(header: HeaderView(allListViewModel: allListViewModel, type: .doing)){
                        ForEach(allListViewModel.service.tasks.filter({ $0.type == .doing })) { task in
                            if let index = allListViewModel.service.tasks.firstIndex(of: task) {
                                CellView(cellViewModel: CellViewModel(withService: allListViewModel.service, task: task), cellIndex: index)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.service.tasks.remove(atOffsets: offset)
                        }
                    }
                }
                .listStyle(.grouped)
            }
            
            // DONE
            VStack(alignment: .leading) {
                List {
                    Section(header: HeaderView(allListViewModel: allListViewModel, type: .done)){
                        ForEach(allListViewModel.service.tasks.filter({ $0.type == .done })) { task in
                            if let index = allListViewModel.service.tasks.firstIndex(of: task) {
                                CellView(cellViewModel: CellViewModel(withService: allListViewModel.service, task: task), cellIndex: index)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.service.tasks.remove(atOffsets: offset)
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
    }
}



struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
        AllListView(allListViewModel: AllListViewModel(withService: TaskManagementService()))
    }
}
