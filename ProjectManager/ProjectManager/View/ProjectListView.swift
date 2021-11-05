//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct ProjectListView: View {
    @EnvironmentObject var projectListViewModel: ProjectListViewModel
    let type: ProjectStatus
    var body: some View {
        VStack {
            HStack {
                Text(type.description)
                    .padding(.leading)
                Text(projectListViewModel.todoCount(type: type))
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Circle())
                Spacer()
            }
            .font(.title)
            .foregroundColor(.black)
            List {
                ForEach(projectListViewModel.filteredList(type: type)) { todo in
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
