//
//  PlanManager.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/14.
//

import Foundation

protocol PlanManager {

    var outputPort: OutputPort? { get set }
    func addPlan(title: String, description: String, deadline: Date)
    func editPlan(title: String, description: String, deadline: Date, identifier: UUID)
    func movePlan(to destination: PlanState, identifier: UUID)
    func removePlan(identifier: UUID) -> Plan?
    func fetchList(of state: PlanState) -> [Plan]
}

final class ProjectManager: PlanManager {

    static let shared: ProjectManager = ProjectManager()
    private var container: [Plan] = [] {
        didSet {
            outputPort?.configurePlanList(toDo: fetchList(of: .toDo),
                                          doing: fetchList(of: .doing),
                                          done: fetchList(of: .done))
        }
    }
    var outputPort: OutputPort?

    private init() { }

    func addPlan(title: String, description: String, deadline: Date) {
        let plan = Project(title: title, description: description, deadline: deadline)
        container.append(plan)
    }

    private func fetchPlan(identifier: UUID) -> Plan? {
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

    func movePlan(to destination: PlanState, identifier: UUID) {
        guard var plan = removePlan(identifier: identifier) else {
            return
        }

        plan.state = destination
        container.append(plan)
    }

    @discardableResult
    func removePlan(identifier: UUID) -> Plan? {
        let plan = fetchPlan(identifier: identifier)
        container = container.filter({ $0.identifier != identifier })

        return plan
    }

    func fetchList(of state: PlanState) -> [Plan] {
        return container.filter({ $0.state == state })
    }
}
