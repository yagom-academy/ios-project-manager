//
//  TaskListHeaderView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct TaskListHeaderView: View {
    
    var status: Status
    var taskCount: Int
    
    var body: some View {
        ZStack {
            Text(status.description)
                .font(.largeTitle)
                .fontWeight(.heavy)
           
                Text(String(taskCount))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct TaskListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListHeaderView(status: .todo, taskCount: 100)
    }
}
