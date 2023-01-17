//
//  ProjectListViewModel.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/16.
//

import Foundation

struct ProjectListViewModel {
    private var onUpdated: ([UUID]) -> Void = { _ in }
    private var updatedProjectsID: [UUID] = []
    private var projects: [Project] {
        didSet {
            onUpdated(updatedProjectsID)
            updatedProjectsID.removeAll()
        }
    }

    init(projects: [Project] = []) {
        self.projects = projects
    }

    mutating func bind(onUpdated: @escaping ([UUID]) -> Void) {
        self.onUpdated = onUpdated
    }

    func projectViewModel(for projectID: UUID) -> ProjectViewModel? {
        guard let project = project(for: projectID) else { return nil }
        let projectViewModel = ProjectViewModel(project: project)
        return projectViewModel
    }

    func project(for projectID: UUID) -> Project? {
        guard let project = projects.first(where: { $0.id == projectID }) else { return nil }
        return project
    }

    func projectIDs(for stateIndex: Int) -> [UUID] {
        return projects.filter { $0.state.rawValue == stateIndex }.map { $0.id }
    }

    func projectState(for index: Int) -> ProjectState? {
            guard let projectState = ProjectState(rawValue: index) else { return nil }
            return projectState
    }

    func projectsCount(for index: Int) -> Int {
        return projects.filter { $0.state.rawValue == index }.count
    }

    mutating func add(project: Project) {
        projects.append(project)
    }

    mutating func update(project: Project) {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else { return }
        updatedProjectsID.append(project.id)
        projects[index] = project
    }

    mutating func delete(for projectID: UUID) {
        projects.removeAll(where: { $0.id == projectID })
    }

    func projectStateCount() -> Int {
        return ProjectState.allCases.count
    }

    func createDueDateAttributedString(_ dueDate: Date) -> NSAttributedString {
        if dueDate.isEarlierThanToday() {
            return NSAttributedString(string: dueDate.localizedDateString(),
                                      attributes: [.foregroundColor: ProjectColor.overdueDate.color])
        } else {
            return NSAttributedString(string: dueDate.localizedDateString())
        }
    }
}
