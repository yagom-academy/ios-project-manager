//
//  ProjectViewModel.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/11.
//

import Foundation

final class ProjectViewModel {

    private var plan: Plan {
        didSet {
            planHandler?(plan)
        }
    }

    private var planHandler: ((Plan) -> Void)?

    init(plan: Plan) {
        self.plan = plan
    }

    func bindPlan(handler: @escaping (Plan) -> Void) {
        self.planHandler = handler
    }
}
