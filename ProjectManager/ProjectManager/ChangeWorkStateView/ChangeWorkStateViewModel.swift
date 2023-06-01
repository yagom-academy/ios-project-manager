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
    enum ButtonIndex: Int {
        case first
        case second
    }
    
    @Published var firstText: String?
    @Published var secondText: String?
    
    weak var delegate: ChangeWorkStateViewModelDelegate?
    
    private let plan: Plan
    private var filteredStates: [WorkState]

    init(from plan: Plan) {
        self.plan = plan
        self.filteredStates = WorkState.allCases
            .filter { $0 != plan.workState }
        
        self.firstText = filteredStates[safe: 0]?.buttonTitle
        self.secondText = filteredStates[safe: 1]?.buttonTitle
    }
    
    func changeWorkState(buttonIndex: ButtonIndex) {
        guard let state = filteredStates[safe: buttonIndex.rawValue] else {
            return
        }
        
        delegate?.changeWorkState(of: plan, to: state)
    }
}
