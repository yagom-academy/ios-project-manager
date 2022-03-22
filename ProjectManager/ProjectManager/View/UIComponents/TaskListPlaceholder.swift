//
//  TaskListPlaceholder.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/14.
//

import SwiftUI

struct TaskListPlaceholder: View {
    
    let taskStatus: TaskStatus
    
    var body: some View {
        Spacer()
        Text("'\(taskStatus.headerTitle)'에 등록된\n할 일이 없습니다.")
            .font(.largeTitle)
            .foregroundColor(.secondary)
        Spacer()
    }
}
