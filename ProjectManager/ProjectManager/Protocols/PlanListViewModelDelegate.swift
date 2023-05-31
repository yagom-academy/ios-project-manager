//
//  PlanListViewModelDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/26.
//

import Foundation

protocol PlanListViewModelDelegate {
    func create(plan: Plan)
    func update(plan: Plan)
    func deletePlan(id: UUID)
}
