//
//  TextColor.swift
//  ProjectManager
//
//  Created by 리지 on 2023/06/01.
//

import UIKit

enum TextColor {
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
