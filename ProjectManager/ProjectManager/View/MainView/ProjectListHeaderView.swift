//
//  ProjectListHeaderView.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/29.
//

import SwiftUI

struct ProjectListHeaderView: View {
    @Binding var count: String
    private let state: ProjectState
    
    init(count: Binding<String>, state: ProjectState) {
        self._count = count
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
                Text(count)
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
}

struct ProjectListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListHeaderView(count: .constant("3"), state: .todo)
    }
}
