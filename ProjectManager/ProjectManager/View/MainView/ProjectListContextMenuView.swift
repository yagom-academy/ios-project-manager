//
//  ProjectListContextMenuView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/29.
//

import SwiftUI

struct ProjectListContextMenuView: View {
    private let state: ProjectState
    private let project: Project
    private let closure: (Project, ProjectState) -> Void
    
    init(state: ProjectState, project: Project, closure: @escaping (Project, ProjectState) -> Void) {

        self.state = state
        self.project = project
        self.closure = closure
    }
    
    var body: some View {
        VStack {
            Button(state.contextItem.first.contextText) {
                closure( project, state.contextItem.first)
            }
            Button(state.contextItem.second.contextText) {
                closure( project, state.contextItem.second)
            }
        }
    }
}

struct ProjectListContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListContextMenuView(
            state: .todo,
            project: .init(title: "", body: "", date: Date()),
            closure: ProjectViewModel().move(project:to:)
        )
        
    }
}
