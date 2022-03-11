//
//  Array+Extension.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/12.
//

import Foundation

extension Array {

    subscript (safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            if indices ~= index {
                self.replaceSubrange(index...index, with: [newValue])
            }
        }
    }
}
