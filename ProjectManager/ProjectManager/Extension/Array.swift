//
//  ArrayExtension.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
