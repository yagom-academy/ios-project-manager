//
//  Array+.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/28.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
