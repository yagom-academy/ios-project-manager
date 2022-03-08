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
            title
            description
            dueDate
        }
    }
    
    var title: some View {
        Text(task.title)
            .font(.headline)
            .lineLimit(0)
    }
    
    var description: some View {
        Text(task.description)
            .font(.subheadline)
            .foregroundColor(.gray)
            .lineLimit(3)
    }
    
    var dueDate: some View {
        let dateView = Text(Self.dateFormatter.string(from: task.dueDate))
        let validDate = Date() - 1
        
        if task.dueDate < validDate, task.status != .done {
            return dateView
                        .foregroundColor(.red)
                        .font(.subheadline)
        } else {
            return dateView
                        .foregroundColor(.black)
                        .font(.subheadline)
        }
    }
    
}
