//
//  ChangeWorkStateViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/29.
//

import Foundation
import Combine

final class ChangeWorkStateViewModel {
    @Published var firstText: String?
    @Published var secondText: String?
    
    init(workState: WorkState) {
        let filteredStateTexts = WorkState.allCases
            .filter { $0 != workState }
            .map { $0.buttonTitle }
        
        firstText = filteredStateTexts[safe: 0]
        secondText = filteredStateTexts[safe: 1]
    }
}
