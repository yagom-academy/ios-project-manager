//
//  SafeIndex.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/27.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
