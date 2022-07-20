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
        if taskType != .done && taskArray[cellIndex].date + (60*60*24) < Date() {
            return Text(taskArray[cellIndex].date.convertDateToString)
                .foregroundColor(.red)
        } else {
            return Text(taskArray[cellIndex].date.convertDateToString)
                .foregroundColor(.black)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(taskArray: ContentViewModel().todoTasks, cellIndex: 0, taskType: .todo).previewLayout(.sizeThatFits)
    }
}
