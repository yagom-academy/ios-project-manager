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
    case changeType(id: UUID, type: ProjectStatus)
}

final class ProjectListViewModel: ObservableObject{
    @Published private(set) var projectList: [Project] = []
    
    func action(_ action: Action) {
        switch action {
        case .create(let project):
            projectList.append(project)
        case .delete(let indexSet):
            projectList.remove(atOffsets: indexSet)
        case .update(let project):
            projectList.firstIndex { $0.id == project.id }.flatMap { projectList[$0] = project }
        case .changeType(let id, let type):
            projectList.firstIndex { $0.id == id }.flatMap { projectList[$0].type = type }
        }
    }
    
    func filteredList(type: ProjectStatus) -> [Project] {
        return projectList.filter {
            $0.type == type
        }
    }
    
    func transitionType(type: ProjectStatus) -> [ProjectStatus] {
        return ProjectStatus.allCases.filter { $0 != type }
    }
    
    func dateFontColor(_ project: Project) -> Color {
        let calendar = Calendar.current
        switch project.type {
        case .todo, .doing:
            if calendar.compare(project.date, to: Date(), toGranularity: .day) == .orderedAscending {
                return .red
            } else {
                return .black
            }
        case .done:
            return .black
        }
    }
}
