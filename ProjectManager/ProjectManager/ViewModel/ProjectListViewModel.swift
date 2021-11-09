//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by KimJaeYoun on 2021/11/02.
//

import SwiftUI

enum Action  {
    case create(project: Project)
    case delete(indexSet: IndexSet)
    case update(project: Project)
}

final class ProjectListViewModel: ObservableObject{
    @Published private(set) var projectList: [ProjectRowViewModel] = []

    func action(_ action: Action) {
        let projectRowViewModel: ProjectRowViewModel
        switch action {
        case .create(let project):
            projectRowViewModel = ProjectRowViewModel(project: project)
            projectRowViewModel.delegate = self
            projectList.append(projectRowViewModel)
        case .delete(let indexSet):
            projectList.remove(atOffsets: indexSet)
        case .update(let project):
            projectRowViewModel = ProjectRowViewModel(project: project)
            projectList.firstIndex { $0.id == projectRowViewModel.id }.flatMap { projectList[$0] = projectRowViewModel }
        }
    }

    func filteredList(type: ProjectStatus) -> [ProjectRowViewModel] {
        return projectList.filter {
            $0.type == type
        }
    }
}

extension ProjectListViewModel: ProjectRowViewModelDelegate {
    func updateViewModel() {
        objectWillChange.send()
    }
}
