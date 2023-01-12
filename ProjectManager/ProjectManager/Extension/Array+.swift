//
//  Array+.swift
//  ProjectManager
//
//  Created by Gundy on 2023/01/12.
//

extension Array {
    func isValid(index: Index) -> Bool {
        return self.count > index
    }
}
