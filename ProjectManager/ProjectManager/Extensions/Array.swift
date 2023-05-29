//
//  ArrayExtension.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set(newValue) {
            if let value = newValue, self.indices ~= index {
                self[index] = value
            }
        }
    }
}
