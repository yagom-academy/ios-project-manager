//
//  ProjectListCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListCell: View {
    let model: Project
    let state: ProjectState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(model.date)
        }
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCell(
            model: Project(title: "안녕", body: "하세요", date: "2022.12.03"),
            state: .doing)
    }
}
