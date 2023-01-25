//
//  ColorPreset.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/25.
//

import UIKit

enum Preset {
    static let defaultBackground = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    static func defaultpopOverArrowPoint(_ cgPoint: CGPoint) -> CGRect {
        return CGRect(x: cgPoint.x, y: cgPoint.y, width: 50, height: 50)
    }
}
