//
//  TodoView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: headerView){
                    ForEach(contentViewModel.todoTasks) { task in
                        if let index = contentViewModel.todoTasks.firstIndex(of: task) {
                            CellView(contentViewModel: contentViewModel, cellIndex: index, taskType: .todo)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .listStyle(.grouped)
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
                Text(String($contentViewModel.todoTasks.count))
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }.foregroundColor(.black)
    }
    
    func delete(at offset: IndexSet) {
        contentViewModel.todoTasks.remove(atOffsets: offset)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(contentViewModel: ContentViewModel()).previewLayout(.sizeThatFits)
    }
}
