//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct ProjectListView: View {
    @EnvironmentObject var projectListViewModel: ProjectListViewModel
    let type: ProjectStatus
    var body: some View {
        let projectList = projectListViewModel.filteredList(type: type)
        VStack {
            HStack {
                Text(type.description)
                    .padding(.leading)
                Text(projectList.count.description)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Circle())
                Spacer()
            }
            .font(.title)
            .foregroundColor(.black)
            List {
                ForEach(projectList) { todo in
                        ProjectRowView(project: todo)
                    }
                    .onDelete { indexSet in projectListViewModel.action(
                        .delete(indexSet: indexSet))
                    }
             }
            .listStyle(.plain)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView(type: .done)
    }
}
