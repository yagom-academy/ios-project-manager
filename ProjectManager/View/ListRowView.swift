//
//  ListRowView.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/06.
//

import SwiftUI

struct ListRowView: View {
    var taskArray: [Task]
    var cellIndex: Int
    var taskType: TaskType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskArray[cellIndex].title)
                .foregroundColor(.black)
            Text(taskArray[cellIndex].body)
                .foregroundColor(.gray)
            checkOverdate()
        }
    }
    
    func checkOverdate() -> some View {
        if task.isOverdate {
            return Text(task.date.convertDateToString)
                .foregroundColor(.red)
        } else {
            return Text(task.date.convertDateToString)
                .foregroundColor(.black)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(taskArray: [], cellIndex: 0, taskType: TaskType.todo)
            .previewLayout(.sizeThatFits)
    }
}
