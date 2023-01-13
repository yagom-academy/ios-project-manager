//
//  ProjectColor.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

enum ProjectColor {
    case viewBackground
    case collectionViewBackground
    case cellBackground

    var color: UIColor {
        switch self {
        case .viewBackground:
            return UIColor.systemGray5
        case .collectionViewBackground:
            return UIColor.systemGray6
        case .cellBackground:
            return UIColor.systemBackground
        }
    }
}
