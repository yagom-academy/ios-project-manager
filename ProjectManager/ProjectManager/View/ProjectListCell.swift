//
//  ProjectListCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListCell: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State var isModalViewShow: Bool = false
    let model: Project
    let dateManager = DateManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(dateManager.formatDateText(date: model.date))
                .foregroundColor(dateManager.checkDeadline(date: model.date) ? .black : .red)
        }.onTapGesture {
            isModalViewShow.toggle()
        }.sheet(isPresented: $isModalViewShow) {
            ModalView(project: model, disableEdit: true, isEditMode: true)
                .environmentObject(viewModel)
        }
        
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCell(
            model: Project(title: "안녕", body: "하세요", date: Date()))
        .environmentObject(ProjectViewModel())
    }
}
