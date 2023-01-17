//
//  PlanManager.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/14.
//

import Foundation

protocol PlanManager {

    func addPlan(title: String, description: String, deadline: Date)
    func editPlan(title: String, description: String, deadline: Date, identifier: UUID)
    func movePlan(to destination: State, identifier: UUID)
    func removePlan(identifier: UUID) -> Project?
    func fetchList(of state: State) -> [Project]
}

final class ProjectManager: PlanManager {

    static let shared: ProjectManager = ProjectManager()
    private var container: [Project] = []

    private init() { }

    func addPlan(title: String, description: String, deadline: Date) {
        let plan = Project(title: title, description: description, deadline: deadline)
        container.append(plan)
    }

    private func fetchPlan(identifier: UUID) -> Project? {
        return container.filter({ $0.identifier == identifier }).first
    }

    private func fetchIndex(identifier: UUID) -> Int? {
        return container.firstIndex { $0.identifier == identifier }
    }

    func editPlan(title: String, description: String, deadline: Date, identifier: UUID) {
        guard let index = fetchIndex(identifier: identifier),
              var plan = removePlan(identifier: identifier) else {
                  return
              }

        plan.title = title
        plan.description = description
        plan.deadline = deadline

        container.insert(plan, at: index)
    }

    func movePlan(to destination: State, identifier: UUID) {
        guard var plan = removePlan(identifier: identifier) else {
            return
        }

        plan.state = destination
        container.append(plan)
    }

    @discardableResult
    func removePlan(identifier: UUID) -> Project? {
        let plan = fetchPlan(identifier: identifier)
        container = container.filter({ $0.identifier != identifier })

        return plan
    }

    func fetchList(of state: State) -> [Project] {
        return container.filter({ $0.state == state })
    }
}
