//
//  AllListView.swift
//  ProjectManager
//
//  Created by marisol on 2022/07/20.
//

import SwiftUI

struct AllListView: View {
    @ObservedObject var allListViewModel = AllListViewModel()
    
    var body: some View {
        HStack {
            // TODO
            VStack(alignment: .leading) {
                List {
                    Section(header: headerView){
                        ForEach(allListViewModel.todoTasks) { task in
                            if let index = allListViewModel.todoTasks.firstIndex(of: task) {
                                CellView(cellIndex: index, taskType: .todo)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.todoTasks.remove(atOffsets: offset)
                        }
                    }
                }
                .listStyle(.grouped)
            }
            
            // DOING
            VStack(alignment: .leading) {
                List {
                    Section(header: headerView){
                        ForEach(allListViewModel.doingTasks) { task in
                            if let index = allListViewModel.todoTasks.firstIndex(of: task) {
                                CellView( cellIndex: index, taskType: .doing)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.doingTasks.remove(atOffsets: offset)
                        }
                    }
                }
                .listStyle(.grouped)
            }
            
            // DONE
            VStack(alignment: .leading) {
                List {
                    Section(header: headerView){
                        ForEach(allListViewModel.doneTasks) { task in
                            if let index = allListViewModel.todoTasks.firstIndex(of: task) {
                                CellView(cellIndex: index, taskType: .done)
                            }
                        }
                        .onDelete { offset in
                            allListViewModel.doneTasks.remove(atOffsets: offset)
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
                Text(String(allListViewModel.todoTasks.count))
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
