//
//  TaskCellView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskCellView: View {
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            
            Text(task.description)
                .foregroundColor(.gray)
            
            Text(task.dueDate.localizedFormat())
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TaskCellView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCellView(
            task: Task(title: "Dummy Title",
                       description: "Dummy description",
                       dueDate: Date.now,
                       status: .todo)
        )
    }
}
