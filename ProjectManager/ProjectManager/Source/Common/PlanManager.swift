//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import Foundation

final class PlanManager: PlanManageable {
    func create(title: String, description: String, deadline: Date) -> Plan? {
return .init(status: .todo, title: title, description: description, deadline: deadline, id: .init())
    }

    func insert(planList: inout [Plan], plan: Plan) {
        planList.append(plan)
    }

    func fetch(id: UUID?) -> UUID? {
        guard id != nil else { return nil }

        return id
    }

    func fetchIndex(list: [Plan] ,id: UUID) -> Array<Plan>.Index? {
        return list.firstIndex(where: { $0.id == id})
    }

    func save(title: String, description: String, deadline: Date, plan: inout Plan?) {
        if fetch(id: plan?.id) == nil {
            plan = create(title: title,
                          description: description,
                          deadline: deadline)
        } else {
            plan?.title = title
            plan?.description = description
            plan?.deadline = deadline
        }
    }

    func update(planList: inout [Plan], plan: Plan) {
        guard let index = planList.firstIndex(where: { $0.id == plan.id}) else { return }

        planList[index].title = plan.title
        planList[index].description = plan.description
        planList[index].deadline = plan.deadline
    }

    func update(list: inout [Plan], id: UUID, status: Plan.Status) {
        guard let index = fetchIndex(list: list, id: id) else { return }

        list[index].status = status
    }

    func delete(planList: inout [Plan], id: UUID?) {
        guard let id = id else { return }

        guard let index = fetchIndex(list: planList, id: id) else { return }

        planList.remove(at: index)
    }

    func isValidContent(_ title: String?, _ description: String?) -> Bool {
        return ((title != PlanText.title && title != PlanText.emptyString) || (description != PlanText.description && description != PlanText.emptyString))
    }
}
