//
//  DetailViewType.swift
//  ProjectManager
//
//  Created by Jinho Choi on 2021/03/12.
//

import Foundation

enum DetailViewType {
    case create
    case edit
    
    var leftButtonName: String {
        switch self {
        case .create:
            return "Cancel"
        case .edit:
            return "Edit"
        }
    }
}
