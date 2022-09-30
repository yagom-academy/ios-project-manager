//
//  ReuseIdentifying.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
