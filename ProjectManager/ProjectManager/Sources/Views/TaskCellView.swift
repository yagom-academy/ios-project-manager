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
        ZStack {
            TaskCellBackgroundView()
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(task.description)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                
                Text(task.dueDate.localizedFormat())
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
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
