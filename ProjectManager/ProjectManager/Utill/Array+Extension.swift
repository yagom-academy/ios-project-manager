//
//  Array+Extension.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/28.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
