//
//  ProjectPlanViewModel.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import SwiftUI

final class ProjectPlanViewModel: ObservableObject {
    @Published private var model = ProjectToDoList(plans: DummyData().data)

    var plans: Array<ProjectToDoList.Plan> {
        model.plans
    }

    func add(title: String, description: String, deadline: Date) {
        model.add(title: title, description: description, deadline: deadline)
    }
    
    func edit(_ plan: ProjectToDoList.Plan, title: String, description: String, deadline: Date) {
        model.edit(plan, title: title, description: description, deadline: deadline)
    }
    
    func change(_ plan: ProjectToDoList.Plan, to state: ProjectToDoList.Plan.State) {
        model.change(plan, to: state)
    }
}
