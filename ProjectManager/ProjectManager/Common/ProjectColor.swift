//
//  ProjectColor.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import UIKit

enum ProjectColor {
    case defaultBackground
    case listViewBackground
    case collectionViewBackground
    case overdueDate
    case itemCountLabelCircleColor
    case itemCountLabelFontColor

    var color: UIColor {
        switch self {
        case .defaultBackground:
            return UIColor.systemBackground
        case .listViewBackground:
            return UIColor.systemGray5
        case .collectionViewBackground:
            return UIColor.systemGray6
        case .overdueDate:
            return UIColor.systemRed
        case .itemCountLabelCircleColor:
            return UIColor.black
        case .itemCountLabelFontColor:
            return UIColor.white
        }
    }
}
