//
//  ChangeWorkStateViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Foundation
import Combine

final class ChangeWorkStateViewModel {
    enum ButtonIndex: Int {
        case first
        case second
    }
    
    @Published var firstText: String?
    @Published var secondText: String?
    
    weak var delegate: ChangeWorkStateViewModelDelegate?
    
    private let taskID: UUID
    private var filteredStates: [WorkState]

    init(from task: Task) {
        self.taskID = task.id
        self.filteredStates = WorkState.allCases
            .filter { $0 != task.workState }
        
        self.firstText = filteredStates[safe: 0]?.buttonTitle
        self.secondText = filteredStates[safe: 1]?.buttonTitle
    }
    
    func changeWorkState(buttonIndex: ButtonIndex) {
        guard let state = filteredStates[safe: buttonIndex.rawValue] else {
            return
        }
        
        delegate?.changeWorkState(taskID: taskID, with: state)
    }
}
