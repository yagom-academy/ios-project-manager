//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    @Binding var viewModel: ProjectViewModel
    private let currentState: ProjectState
    
    init(viewModel: Binding<ProjectViewModel>, currentState: ProjectState) {
        self._viewModel = viewModel
        self.currentState = currentState
    }
    
    var body: some View {
        List {
            Section {
                let list = viewModel.search(state: currentState)
                
                createListItems(for: list) { indexSet in
                    viewModel.delete(state: currentState, at: indexSet)
                }
            } header: {
                ProjectListHeaderView(viewModel: $viewModel, state: currentState)
            }
        }
        .listStyle(.grouped)
    }
 
}

private extension ProjectListView {
    func createListItems(for models: [Project], onDelete: @escaping (IndexSet) -> Void) -> some View {
        ForEach(models) { model in
            ProjectListCell(viewModel: $viewModel, model: model)
                .contextMenu {
                    ProjectListContextMenuView(viewModel: $viewModel, state: currentState, project: model)
                }
        }
        .onDelete(perform: onDelete)
        .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .listRowBackground(
            Rectangle()
                .fill(.white)
                .padding(.top, 10)
        )
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(viewModel: .constant(ProjectViewModel()), currentState: .todo)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
