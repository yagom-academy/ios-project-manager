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
    let taskID: UUID
    weak var delegate: ChangeWorkStateViewModelDelegate?
    var filteredStates: [WorkState]
    
    init(from task: Task) {
         filteredStates = WorkState.allCases
            .filter { $0 != task.workState }
        
        firstText = filteredStates[safe: 0]?.buttonTitle
        secondText = filteredStates[safe: 1]?.buttonTitle
        taskID = task.id
    }
    
    func changeWorkState(_ index: ButtonIndex) {
        guard let state = filteredStates[safe: index.rawValue] else {
            return
        }
        
        delegate?.changeTaskWorkState(id: taskID, with: state)
    }
}
