//
//  ReuseIdentifiable.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
