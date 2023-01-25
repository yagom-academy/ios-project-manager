//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

final class PlanManager: PlanManageable {
    private var store = Store(planList: MockData.projects).planList

    func create(title: String, description: String, deadline: Date) -> Plan {
        return .init(status: .todo, title: title, description: description, deadline: deadline, id: .init())
    }

    func insert(plan: Plan) {
        store.append(plan)
    }

    func fetchAll(status: Plan.Status) -> [Plan] {
        return store.filter { $0.status == status }
    }

    func isExistID(id: UUID?) -> Bool {
        guard id != nil else { return false }

        return true
    }

    func fetchIndex(id: UUID) -> Array<Plan>.Index? {
        return store.firstIndex(where: { $0.id == id})
    }

    func update(plan: Plan) {
        guard let index = fetchIndex(id: plan.id) else { return }

        store[index].title = plan.title
        store[index].description = plan.description
        store[index].deadline = plan.deadline
    }

    func update(id: UUID, status: Plan.Status) {
        guard let index = fetchIndex(id: id) else { return }

        store[index].status = status
    }

    func delete(id: UUID?) {
        guard let id = id else { return }

        guard let index = fetchIndex(id: id) else { return }

        store.remove(at: index)
    }

    func isValidContent(_ title: String?, _ description: String?) -> Bool {
        return ((title != PlanText.title && title != PlanText.emptyString) || (description != PlanText.description && description != PlanText.emptyString))
    }
}
