//
//  ProjectListSectionView.swift
//  ProjectManager
//
//  Created by kaki on 2023/05/31.
//

import SwiftUI

struct ProjectListSectionView: View {
    @ObservedObject var viewModel: ProjectViewModel
    private let state: ProjectState
    
    init(viewModel: ObservedObject<ProjectViewModel>, state: ProjectState) {
        self._viewModel = viewModel
        self.state = state
    }
    
    var body: some View {
        let list = viewModel.search(state: state)
        
        ForEach(list) { project in
            ProjectListCell(viewModel: _viewModel, model: project)
                .contextMenu {
                    ProjectListContextMenuView( state: state, project: project, closure: viewModel.move(project:to:))
                }
        }
        .onDelete(perform: { indexSet in
            viewModel.delete(state: state, at: indexSet)
        })
        .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .listRowBackground(
            Rectangle()
                .fill(.white)
                .padding(.top, 10)
            )
    }
}

struct ProjectListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListSectionView(
            viewModel: .init(wrappedValue: ProjectViewModel()),
            state: .todo
        )
    }
}
