//
//  ProjectListCell.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListCell: View {
    @ObservedObject var viewModel: ProjectViewModel
    @State private var isModalViewShow = false
    private let model: Project
    private let dateManager = DateManager.shared
    
    init(viewModel: ObservedObject<ProjectViewModel>, model: Project) {
            self._viewModel = viewModel
            self.model = model
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(model.title)
                .lineLimit(1)
            Text(model.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Text(dateManager.formatDateText(date: model.date, mode: .display))
                .foregroundColor(dateManager.checkDeadline(date: model.date) ? .black : .red)
        }.onTapGesture {
            isModalViewShow.toggle()
        }.sheet(isPresented: $isModalViewShow) {
            ProjectDetailView(viewModel: _viewModel, project: model, disableEdit: true, isEditMode: true)
        }
        
    }
}

struct ProjectListCell_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListCell(
            viewModel: .init(wrappedValue: ProjectViewModel()),
            model: Project(title: "안녕", body: "하세요", date: Date()))
    }
}
