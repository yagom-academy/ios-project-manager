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
            projectRowViewModel.delegate = self
            projectList.firstIndex { $0.id == projectRowViewModel.id }.flatMap { projectList[$0] = projectRowViewModel }
        }
    }

    func selectedProject(from id: UUID?) -> ProjectRowViewModel? {
        if let id = id, let index = projectList.firstIndex(where: { $0.id == id }) {
            return projectList[index]
        }
        return nil
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
