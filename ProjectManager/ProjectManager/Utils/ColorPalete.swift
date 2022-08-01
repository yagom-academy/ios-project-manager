//
//  ColorPalete.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/15.
//

import UIKit

enum DateLabelColor {
    case red
    case black

    var color: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .black:
            return UIColor.black
        }
    }
}
