//
//  ChangeWorkStateViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Foundation
import Combine

protocol ChangeWorkStateViewModelDelegate: AnyObject {
    func changeWorkState(of plan: Plan, to workState: WorkState)
}

final class ChangeWorkStateViewModel {
    struct Input {
        let firstButtonTappedEvent: AnyPublisher<Void, Never>
        let secondButtonTappedEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let dismissTrigger: AnyPublisher<Void, Never>
    }
    
    weak var delegate: ChangeWorkStateViewModelDelegate?
    
    private let plan: Plan
    var filteredStates: [WorkState]

    init(from plan: Plan) {
        self.plan = plan
        self.filteredStates = WorkState.allCases
            .filter { $0 != plan.workState }
    }
    
    func transform(input: Input) -> Output {
        let firstButtonPublisher = input.firstButtonTappedEvent
            .map { [weak self] in
                guard let self, let state = self.filteredStates[safe: 0] else { return }
                
                self.delegate?.changeWorkState(of: self.plan, to: state)
            }
        
        let secondButtonPublisher = input.secondButtonTappedEvent
            .map { [weak self] in
                guard let self, let state = self.filteredStates[safe: 1] else { return }
                
                self.delegate?.changeWorkState(of: self.plan, to: state)
            }
        
        let dismissTrigger = firstButtonPublisher
            .merge(with: secondButtonPublisher)
            .eraseToAnyPublisher()
        
        return Output(dismissTrigger: dismissTrigger)
    }
}
