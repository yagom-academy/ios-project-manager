//
//  PlanManagerViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/25.
//

import Foundation
import Combine

final class PlanManagerViewModel {
    @Published var planList: [Plan] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let todoViewModel: PlanViewModel
    private let doingViewModel: PlanViewModel
    private let doneViewModel: PlanViewModel
    
    init(todoViewModel: PlanViewModel, doingViewModel: PlanViewModel, doneViewModel: PlanViewModel) {
        self.todoViewModel = todoViewModel
        self.doingViewModel = doingViewModel
        self.doneViewModel = doneViewModel
        setUpBindings()
    }
    
    private func setUpBindings() {
        bindItem()
        bindDelete()
        bindChange()
    }
    
    private func bindItem() {
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .todo
                }
            }
            .assign(to: \.plan, on: todoViewModel)
            .store(in: &cancellables)
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .doing
                }
            }
            .assign(to: \.plan, on: doingViewModel)
            .store(in: &cancellables)
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .done
                }
            }
            .assign(to: \.plan, on: doneViewModel)
            .store(in: &cancellables)
    }
    
    private func bindDelete() {
        todoViewModel.deletePublisher
            .sink { [weak self] plan in
                self?.delete(by: plan.id)
            }
            .store(in: &cancellables)
        doingViewModel.deletePublisher
            .sink { [weak self] plan in
                self?.delete(by: plan.id)
            }
            .store(in: &cancellables)
        doneViewModel.deletePublisher
            .sink { [weak self] plan in
                self?.delete(by: plan.id)
            }
            .store(in: &cancellables)
    }
    
    private func bindChange() {
        todoViewModel.changePublisher
            .sink { [weak self] (plan, state) in
                self?.changeState(plan: plan, state: state)
            }
            .store(in: &cancellables)
        doingViewModel.changePublisher
            .sink { [weak self] (plan, state) in
                self?.changeState(plan: plan, state: state)
            }
            .store(in: &cancellables)
        doneViewModel.changePublisher
            .sink { [weak self] (plan, state) in
                self?.changeState(plan: plan, state: state)
            }
            .store(in: &cancellables)
    }
    
    func create(_ plan: Plan) {
        planList.append(plan)
    }
    
    private func delete(by id: UUID) {
        planList.removeAll { $0.id == id }
    }
    
    private func changeState(plan: Plan, state: State) {
        guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
        
        var plan = planList[index]
        plan.state = state
      
        update(by: plan)
    }
    
    func update(by plan: Plan) {
        guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
        self.planList[index] = plan
    }
}
