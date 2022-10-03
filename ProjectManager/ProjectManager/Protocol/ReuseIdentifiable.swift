//
//  ReuseIdentifiable.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/06.
//

protocol ReuseIdentifiable {
    static var identifier: String { get }
}

extension ReuseIdentifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
