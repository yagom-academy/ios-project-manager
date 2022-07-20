////
////  DoneView.swift
////  ProjectManager
////
////  Created by OneTool, marisol on 2022/07/06.
////
//
//import SwiftUI
//
//struct DoneView: View {
//    var taskManagementService: TaskManagementService
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            List {
//                Section(header: headerView) {
//                    ForEach(taskManagementService.allListViewModel.doneTasks) { task in
//                        if let index = taskManagementService.allListViewModel.doneTasks.firstIndex(of: task) {
//                            CellView(cellIndex: index, taskType: .done)
//                        }
//                    }
//                    .onDelete { offset in
//                        taskManagementService.allListViewModel.doneTasks.remove(atOffsets: offset)
//                    }
//                }
//            }
//            .listStyle(.grouped)
//        }
//    }
//
//    var headerView: some View {
//        HStack {
//            Text(TaskType.done.title)
//                .font(.largeTitle)
//                .foregroundColor(.black)
//            ZStack {
//            Circle()
//                .frame(width: 25, height: 25)
//                Text(String(taskManagementService.allListViewModel.doneTasks.count))
//                    .foregroundColor(.white)
//                    .font(.title2)
//            }
//        }.foregroundColor(.black)
//    }
//}
//
//struct DoneView_Previews: PreviewProvider {
//    static var previews: some View {
//        DoneView(taskManagementService: TaskManagementService()).previewLayout(.sizeThatFits)
//    }
//}
