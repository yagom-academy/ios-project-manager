//
//  AllListView.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import SwiftUI

struct AllListView: View {
    @ObservedObject var allListViewModel: AllListViewModel
    
    var body: some View {
        HStack {
            // TODO
            VStack(alignment: .leading) {
                List {
                    Section(header: headerView){
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
                    Section(header: headerView){
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
                    Section(header: headerView){
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
    
    var headerView: some View {
        HStack {
            Text(TaskType.todo.title)
                .font(.largeTitle)
                .foregroundColor(.black)
            ZStack {
            Circle()
                .frame(width: 25, height: 25)
                Text(String(allListViewModel.service.tasks.count))
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
}

//struct AllListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllListView()
//    }
//}
