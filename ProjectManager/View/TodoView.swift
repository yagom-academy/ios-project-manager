////
////  TodoView.swift
////  ProjectManager
////
////  Created by OneTool, marisol on 2022/07/06.
////
//
//import SwiftUI
//
//struct TodoView: View {
//    @ObservedObject var contentViewModel: TaskManagementService
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            List {
//                Section(header: headerView){
//                    ForEach(contentViewModel.todoTasks) { task in
//                        if let index = contentViewModel.todoTasks.firstIndex(of: task) {
//                            CellView(contentViewModel: contentViewModel, cellIndex: index, taskType: .todo)
//                        }
//                    }
//                    .onDelete { offset in
//                        contentViewModel.todoTasks.remove(atOffsets: offset)
//                    }
//                }
//            }
//            .listStyle(.grouped)
//        }
//    }
//    
//    var headerView: some View {
//        HStack {
//            Text(TaskType.todo.title)
//                .font(.largeTitle)
//                .foregroundColor(.black)
//            ZStack {
//            Circle()
//                .frame(width: 25, height: 25)
//                Text(String($contentViewModel.todoTasks.count))
//                    .foregroundColor(.white)
//                    .font(.title2)
//            }
//        }.foregroundColor(.black)
//    }
//}
//
////struct TodoView_Previews: PreviewProvider {
////    static var previews: some View {
////        TodoView(contentViewModel: SomeViewModel()).previewLayout(.sizeThatFits)
////    }
////}
