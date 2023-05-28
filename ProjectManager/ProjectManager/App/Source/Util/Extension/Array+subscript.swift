//
//  Array+subscript.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/25.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return indices ~= index ? self[index] : nil
        }
        set {
            guard let newValue,
                  indices ~= index else { return }
            
            self[index] = newValue
        }
    }
}
