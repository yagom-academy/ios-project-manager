//
//  Array+.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/26.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
