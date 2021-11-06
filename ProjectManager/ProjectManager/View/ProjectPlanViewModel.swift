//
//  ProjectPlanViewModel.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import SwiftUI

final class ProjectPlanViewModel: ObservableObject {
    @Published private var model: ProjectToDoList = ProjectToDoList(plans: DummyData().data)

    var plans: Array<ProjectToDoList.Plan> {
        model.plans
    }
    
    func add(_ plan: ProjectToDoList.Plan) {
        model.add(plan)
    }
    
    func change(_ plan: ProjectToDoList.Plan, to state: ProjectToDoList.Plan.State) {
        model.change(plan, to: state)
    }
}
