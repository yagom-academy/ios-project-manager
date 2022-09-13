//
//  ReuseIdentifying.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/12/22.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
