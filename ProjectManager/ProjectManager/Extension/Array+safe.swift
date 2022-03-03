//
//  Array+safe.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/03.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
