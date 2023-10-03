//
//  Action.swift
//  ProjectManager
//
//  Created by Max on 2023/10/03.
//

struct Action {
    let type: ActionType
    let extraInformation: [KeywordArgument]
    
    init(type: ActionType, extraInformation: [KeywordArgument] = []) {
        self.type = type
        self.extraInformation = extraInformation
    }
    
    enum ActionType {
        case create
        case update
        case delete
    }
}
