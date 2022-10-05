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
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Text(task.dueDate, formatter: Date.formatter)
                    .foregroundColor(isOver(task.dueDate) ? .red : .primary)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private extension TaskCellView {
    
    func isOver(_ dueDate: Date) -> Bool {
        if dueDate < Date.now && !Calendar.current.isDateInToday(dueDate) {
            return true
        }
        
        return false
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
