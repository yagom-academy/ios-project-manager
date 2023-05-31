//
//  ProjectListHeaderView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/29.
//

import SwiftUI

struct ProjectListHeaderView: View {
    @Binding var viewModel: ProjectViewModel
    private let state: ProjectState
    
    init(viewModel: Binding<ProjectViewModel>, state: ProjectState) {
        self._viewModel = viewModel
        self.state = state
    }

    var body: some View {
        HStack {
            Text(state.rawValue)
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.light)
            ZStack {
                Circle()
                    .fill(.black)
                    .frame(width: 25)
                Text(String(viewModel.search(state: state).count))
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ProjectListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListHeaderView(viewModel: .constant(ProjectViewModel()), state: .todo)
    }
}
