//
//  ProjectMangerRow.swift
//  ProjectManager
//
//  Created by 이예원 on 2021/11/02.
//

import SwiftUI

struct ProjectMangerRow: View {
    let project: ProjectModel
    let currentDate = Self.dateFormatter.string(from: Date())
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter
    }()
    
    var body: some View {
        let dueDate = Self.dateFormatter.string(from: project.date)
        VStack(alignment: .leading) {
            Text(project.title)
                .font(.title2)
            Text(project.description)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3)
            Text(dueDate)
                .foregroundColor(dueDate < currentDate ? .red : .black )
        }
        .listRowBackground(Color.white)
    }
}
