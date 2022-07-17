//
//  Collection.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/15.
//

extension Array {
  subscript (safe index: Index) -> Element? {
    return self.indices ~= index ? self[index] : nil
  }
}
