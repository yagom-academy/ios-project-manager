//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

class PlanManager: PlanManageable {
    func create(planList: inout [Plan]) throws {
        let plan = Plan(status: .todo,
                        title: "",
                        description: "",
                        deadline: Date(),
                        id: UUID())

        planList.append(plan)
    }

    func fetch(id: UUID) throws -> Plan? {
        fatalError()
    }

    func fetchAllPlans() throws {
        fatalError()
    }

    func update(planList: inout [Plan], plan: Plan) throws {
        guard let index = planList.firstIndex(where: { $0.id == plan.id}) else { return }

        planList[index].title = plan.title
        planList[index].description = plan.description
        planList[index].deadline = plan.deadline
    }

    func update(id: UUID, status: Plan.Status) throws {
        fatalError()
    }

    func delete(id: UUID) throws {
        fatalError()
    }
}
