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
    case networkStatusLabelFontColor
    case undoButtonTintColor
    case redoButtonTintColor

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
        case .networkStatusLabelFontColor:
            return UIColor.systemRed
        case .undoButtonTintColor:
            return UIColor.systemBlue
        case .redoButtonTintColor:
            return UIColor.systemRed
        }
    }
}
