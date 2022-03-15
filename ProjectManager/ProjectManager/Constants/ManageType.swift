//
//  ManageType.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/15.
//

import UIKit

enum ManageType {
    case add
    case edit
    case detail
    
    var leftButtonItem: UIBarButtonItem.SystemItem {
        switch self {
        case .add, .edit:
            return .cancel
        case .detail:
            return .edit
        }
    }
}
