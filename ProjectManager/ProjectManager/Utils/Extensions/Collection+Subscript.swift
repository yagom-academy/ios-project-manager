//
//  Collection+Subscript.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/28.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
