//
//  PlanDelegate.swift
//  ProjectManager
//
//  Created by som on 2023/01/25.
//

protocol PlanListDelegate {
    func sendToAdd(plan: Plan)
    func sendToUpdate(plan: Plan)
}

protocol PlanDelegate {
    func add(plan: Plan)
    func update(plan: Plan)
    func updateStatus(plan: Plan, status: Plan.Status)
    func delete(plan: Plan)
}
