//
//  Reusable.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/13.
//

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
