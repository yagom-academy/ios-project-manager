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
                ProjectListSectionView(viewModel: $viewModel, state: currentState)
                    .listRowInsets(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .listRowBackground(
                        Rectangle()
                            .fill(.white)
                            .padding(.top, 10)
                    )
            } header: {
                let count = viewModel.search(state: currentState).count
                let binding = Binding<String>.constant("\(count)")
                
                ProjectListHeaderView(count: binding, state: currentState)
            }
        }
        .listStyle(.grouped)
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(viewModel: .constant(ProjectViewModel()), currentState: .todo)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
