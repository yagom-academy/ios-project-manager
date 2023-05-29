//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    @EnvironmentObject private var viewModel: ProjectViewModel
    let currentState: ProjectState
    
    var body: some View {
        List {
            Section {
                let list = viewModel.search(state: currentState)
                
                createListItems(for: list) { indexSet in
                    viewModel.delete(state: currentState, at: indexSet)
                }
            } header: {
                ProjectListHeaderView(state: currentState)
                    .environmentObject(viewModel)
            }
        }
        .listStyle(.grouped)
    }
 
}

private extension ProjectListView {
    func createListItems(for models: [Project], onDelete: @escaping (IndexSet) -> Void) -> some View {
        ForEach(models) { model in
            ProjectListCell(model: model)
                .environmentObject(viewModel)
                .contextMenu {
                    ProjectListContextMenuView(state: currentState, project: model)
                        .environmentObject(viewModel)
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
        ProjectListView(currentState: .todo)
            .environmentObject(ProjectViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
