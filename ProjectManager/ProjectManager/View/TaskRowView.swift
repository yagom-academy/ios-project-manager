//
//  TaskRowView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/06.
//

import SwiftUI

struct TaskRowView: View {
    
    let task: Task
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        return formatter
    }()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            Text(task.description)
                .font(.subheadline)
            Text(Self.dateFormatter.string(from: task.dueDate))
        }
        
    }
    
}
