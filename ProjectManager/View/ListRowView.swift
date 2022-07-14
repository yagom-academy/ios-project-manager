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
    
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(taskArray[cellIndex].title)
                    .foregroundColor(.black)
                Text(taskArray[cellIndex].body)
                    .foregroundColor(.gray)
                Text(taskArray[cellIndex].date.convertDateToString)
                    .foregroundColor(.black)
            }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(taskArray: ContentViewModel().todoTasks, cellIndex: 0).previewLayout(.sizeThatFits)
    }
}
