//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

import SwiftUI

struct ProjectListView: View {
    @ObservedObject var viewModel: ProjectViewModel
    private let currentState: ProjectState
    
    init(viewModel: ObservedObject<ProjectViewModel>, currentState: ProjectState) {
        self._viewModel = viewModel
        self.currentState = currentState
    }
    
    var body: some View {
        List {
            Section {
                ProjectListSectionView(viewModel: _viewModel, state: currentState)
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
        ProjectListView(viewModel: .init(wrappedValue: ProjectViewModel()), currentState: .todo)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
