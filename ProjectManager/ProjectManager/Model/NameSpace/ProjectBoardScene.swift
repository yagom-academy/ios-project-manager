//
//  ProjectBoardScene.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/15.
//

import Foundation

enum ProjectBoardScene: String {
    
    case mainTitle =  "Project Manager"
    
    enum statusModification: String {
        
        case todo = "move to TODO"
        case doing = "move to DOING"
        case done = "move to DONE"
    }
}
