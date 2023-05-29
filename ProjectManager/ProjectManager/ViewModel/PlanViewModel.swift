//
//  PlanViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/17.
//

import Foundation
import Combine

final class PlanViewModel {
    @Published var plan: [Plan] = []
    let updatePublisher = PassthroughSubject<Plan, Never>()
    let deletePublisher = PassthroughSubject<Plan, Never>()
    let changePublisher = PassthroughSubject<(Plan, State), Never>()
    
    private let state: State
    private var cancellables = Set<AnyCancellable>()

    private(set) var currentLongPressedCell: PlanTableViewCell?
    
    init(state: State) {
        self.state = state
    }
    
    var firstActionTitle: String {
        let (first, _) = state.checkOrder()
        return "Move to \(first)"
    }
    
    var secondActionTitle: String {
        let (_, second) = state.checkOrder()
        return "Move to \(second)"
    }
    
    var moveToFirst: State {
        let (first, _) = state.moveByState()
        return first
    }
    
    var moveToSecond: State {
        let (_, second) = state.moveByState()
        return second
    }
    
    var numberOfItems: Int {
        return plan.count
    }
    
    func read(at indexPath: IndexPath) -> Plan {
        return plan[indexPath.row]
    }
    
    func delete(_ plan: Plan) {
        deletePublisher.send(plan)
    }

    func update(by plan: Plan) {
        updatePublisher.send(plan)
    }
    
    func changeState(plan: Plan, state: State) {
        changePublisher.send((plan, state))
    }
    
    func updateCurrentCell(_ cell: PlanTableViewCell) {
        currentLongPressedCell = cell
    }
}
