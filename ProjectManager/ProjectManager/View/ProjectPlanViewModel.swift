//
//  ProjectPlanViewModel.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/03.
//

import SwiftUI

final class ProjectPlanViewModel: ObservableObject {
    @Published private var model = ProjectToDoList(plans: DummyData().data)
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var plans: Array<ProjectToDoList.Plan> {
        model.plans
    }

    func add(title: String, description: String, deadline: Date) {
        model.add(title: title, description: description, deadline: deadline)
    }
    
    func edit(_ plan: ProjectToDoList.Plan, title: String, description: String, deadline: Date) {
        model.edit(plan, title: title, description: description, deadline: deadline)
    }
    
    func delete(at indexSet: IndexSet) {
        model.delete(at: indexSet)
    }
    
    func change(_ plan: ProjectToDoList.Plan, to state: ProjectToDoList.Plan.State) {
        model.change(plan, to: state)
    }
    
    func isOverdue(_ plan: ProjectToDoList.Plan) -> Bool {
        let current = Date()
        let calendar = Calendar.current
        if calendar.compare(current, to: plan.deadline, toGranularity: .day) == .orderedDescending {
            return true
        }
        return false
    }
    
    func format(date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    func number(of state: String) -> Int {
        plans.filter({ $0.state.description == state }).count
    }
}
