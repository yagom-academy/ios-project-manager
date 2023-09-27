//
//  ColorSet.swift
//  ProjectManager
//
//  Created by Mary & Dasan on 2023/09/28.
//

import SwiftUI

struct ColorSet {
    static let navigationBarBackground = CustomColor.lightGray
    static let backgroundBetweenLists = CustomColor.darkGray
    static let border = CustomColor.border
    static let background = CustomColor.gray
    
    enum CustomColor {
        static let lightGray = Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255)
        static let darkGray = Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
        static let border = Color(red: 222 / 255, green: 222 / 255, blue: 226 / 255)
        static let gray = Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255)
    }
}
