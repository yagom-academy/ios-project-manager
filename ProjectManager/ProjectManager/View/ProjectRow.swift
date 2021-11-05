//
//  ProjectRow.swift
//  ProjectManager
//
//  Created by 홍정아 on 2021/11/02.
//

import SwiftUI

struct ProjectRow: View {
    
    let project: ProjectModel.Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.title)
                    .font(.title2)
                Text(project.content)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                Text(project.dueDate.formatted)
                    .font(.callout)
                    .foregroundColor(project.dueDate.isExpired ? .red : .black)
            }
            Spacer()
        }
    }
}

struct ProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRow(project: ProjectModel.Project(id: UUID(), title: "책상정리", content: "집중이 안될땐 역시나 책상정리", dueDate: Date(), created: Date(), status: .todo))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
