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
    @State var isModalViewShow: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(ProjectDateFormatter.shared.formatDateText(date: model.date))
        }.onTapGesture {
            isModalViewShow.toggle()
        }.sheet(isPresented: $isModalViewShow) {
            ModalView(project: model, disableEdit: true, isEdit: true)
        }
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCell(
            model: Project(title: "안녕", body: "하세요", date: Date()),
            state: .doing)
    }
}
