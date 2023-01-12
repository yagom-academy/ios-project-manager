//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

final class ProjectViewModel {

    private var plan: Plan
    private var isEditable: Bool = false {
        didSet {
            editHandler?(isEditable)
        }
    }
    private var editHandler: ((Bool) -> Void)?

    init(plan: Plan) {
        self.plan = plan
    }

    func bindEdit(handler: @escaping (Bool) -> Void) {
        self.editHandler = handler
    }

    func changeEditable(state: Bool) {
        self.isEditable = state
    }

    func editPlan(title: String, description: String, deadline: Date) {
        editTitle(text: title)
        editDescription(text: description)
        editDeadline(date: deadline)
    }

    private func editTitle(text: String) {
        guard plan.title != text else {
            return
        }
        plan.title = text
    }

    private func editDescription(text: String) {
        guard plan.description != text else {
            return
        }
        plan.description = text
    }

    private func editDeadline(date: Date) {
        guard plan.deadline != date else {
            return
        }
        plan.deadline = date
    }

    func changeState(to state: PlanState) {
        guard isSameState(with: state) == false else {
            return
        }
        plan.state = state
    }

    private func isSameState(with state: PlanState) -> Bool {
        return plan.state == state
    }
}
