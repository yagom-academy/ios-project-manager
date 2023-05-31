//
//  ArraySubscript.swift
//  ProjectManager
//
//  Created by goat on 2023/05/31.
//

import Foundation

extension Array {
    subscript(index index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
