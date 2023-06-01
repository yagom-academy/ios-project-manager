//
//  ProjectListSectionView.swift
//  ProjectManager
//
//  Created by kaki on 2023/05/31.
//

import SwiftUI

struct ProjectListSectionView: View {
    @Binding var viewModel: ProjectViewModel
    private let state: ProjectState
    
    init(viewModel: Binding<ProjectViewModel>, state: ProjectState) {
        self._viewModel = viewModel
        self.state = state
    }
    
    var body: some View {
        let list = viewModel.search(state: state)
        
        ForEach(list) { project in
            ProjectListCell(viewModel: $viewModel, model: project)
                .contextMenu {
                    ProjectListContextMenuView(viewModel: $viewModel, state: state, project: project)
                }
        }
        .onDelete(perform: { indexSet in
            viewModel.delete(state: state, at: indexSet)
        })
    }
}

struct ProjectListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListSectionView(
            viewModel: .constant(ProjectViewModel()),
            state: .todo
        )
    }
}
