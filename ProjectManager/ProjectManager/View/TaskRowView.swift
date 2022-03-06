//
//  TaskRowView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/06.
//

import SwiftUI

struct TaskRowView: View {
    
    let task: Task
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            Text(task.description)
                .font(.subheadline)
            Text(task.dueDate.description)
        }
        
    }
    
}
