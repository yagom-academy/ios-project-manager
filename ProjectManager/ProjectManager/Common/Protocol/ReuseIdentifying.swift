//
//  ReuseIdentifying.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/16.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
