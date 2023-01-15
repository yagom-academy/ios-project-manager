//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

protocol PlanViewModel {

    var title: String? { get }
    var description: String? { get }
    var deadlineText: String? { get }
    var isOverDue: Bool? { get }
    init(plan: Plan?)
    func bindEdit(handler: @escaping (Bool) -> Void)
    func changeEditable(state: Bool)
}

final class ProjectViewModel: PlanViewModel {

    private var plan: Plan?
    private var isEditable: Bool = false {
        didSet {
            editHandler?(isEditable)
        }
    }
    private var editHandler: ((Bool) -> Void)?
    var title: String? {
        return plan?.title
    }
    var description: String? {
        return plan?.description
    }
    var deadlineText: String? {
        return plan?.deadline.localeFormattedText
    }
    var isOverDue: Bool? {
        return plan?.deadline.isOverdue
    }

    init(plan: Plan? = nil) {
        self.plan = plan
    }

    func bindEdit(handler: @escaping (Bool) -> Void) {
        editHandler = handler
    }

    func changeEditable(state: Bool) {
        isEditable = state
    }
}
