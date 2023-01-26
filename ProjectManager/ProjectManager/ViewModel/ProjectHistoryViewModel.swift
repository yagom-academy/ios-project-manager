//
//  ProjectHistoryViewModel.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/26.
//

import Foundation

struct ProjectHistoryViewModel {

    private(set) var histories: [ProjectHistory] = []
    
    func fetchHistoryTitle(_ projectHistory: ProjectHistory) -> String {
        let projectTitle = projectHistory.Project.title ?? ""
        
        switch projectHistory.change {
        case .add:
            return "Added `\(projectTitle)`"
        case .remove(let state):
            return "Removed `\(projectTitle)` from \(state.title)"
        case .update:
            return "Updated `\(projectTitle)`"
        case .move(let beforeState, let afterState):
            return "Moved `\(projectTitle)` from \(beforeState.title) to \(afterState.title)"
        }
    }
    
    func fetchHistoryDate(_ projectHistory: ProjectHistory) -> String {
        return projectHistory.changeDate.changeHistoryDateFormatString()
    }
}
