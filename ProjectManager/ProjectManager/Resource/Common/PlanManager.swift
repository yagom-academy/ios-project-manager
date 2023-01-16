//
//  ToDoManager.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

class PlanManager: PlanManageable {
    func create() -> Plan {
        fatalError()
    }

    func fetch(id: UUID) -> Plan? {
        fatalError()
    }

    func fetchAllPlans() throws {
        fatalError()
    }

    func update(plan: Plan) throws {
        fatalError()
    }

    func update(id: UUID, status: Plan.Status) throws {
        fatalError()
    }

    func delete(id: UUID) {
        fatalError()
    }
}
