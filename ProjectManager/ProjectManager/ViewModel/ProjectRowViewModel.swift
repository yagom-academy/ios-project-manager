//
//  ProjectRowViewModel.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/09.
//

import SwiftUI


protocol ProjectRowViewModelDelegate: AnyObject {
    func updateViewModel()
}

final class ProjectRowViewModel: ObservableObject, Identifiable {
    @Published private var project: Project
    weak var delegate: ProjectRowViewModelDelegate?
    enum Action {
        case changeType(type: ProjectStatus)
    }

    init(project: Project) {
        self.project = project
    }

    var id: UUID {
        return project.id
    }

    var title: String {
        return project.title
    }

    var date: String {
        return DateFormatter.convertDate(date: project.date)
    }

    var description: String {
        return project.description
    }

    var type: ProjectStatus {
        return project.type
    }

    var dateFontColor: Color {
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

    func action(_ action: Action) {
        switch action {
        case .changeType(let type):
            project.type = type
            delegate?.updateViewModel()
        }
    }

    var transitionType: [ProjectStatus] {
        return ProjectStatus.allCases.filter { $0 != project.type }
    }
}
