//
//  ToDoManageable.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import Foundation

protocol PlanManageable {
    func create(planList: inout [Plan]) throws
    func update(planList: inout [Plan], plan: Plan) throws
    func update(id: UUID, status: Plan.Status) throws
    func fetch(id: UUID) throws -> Plan?
    func fetchAllPlans() throws
    func delete(id: UUID) throws
}
