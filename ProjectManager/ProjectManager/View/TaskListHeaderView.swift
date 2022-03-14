//
//  TaskListHeaderView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/14.
//

import SwiftUI

struct TaskListHeaderView: View {
    
    let taskStatus: TaskStatus
    let tasksCount: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(taskStatus.headerTitle)
                .font(.largeTitle)
            Text(tasksCount)
                .frame(width: 30, height: 24)
                .font(.title3)
                .lineLimit(1)
                .foregroundColor(.primary)
                .colorInvert()
                .padding(.all, 5)
                .background(Color.primary)
                .clipShape(Circle())
                .minimumScaleFactor(0.8)
            Spacer()
        }
        .padding(EdgeInsets(top: 11, leading: 21, bottom: -1, trailing: 21))
    }
}
