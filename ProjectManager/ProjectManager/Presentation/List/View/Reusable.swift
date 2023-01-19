//
//  Reusable.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

protocol Reusable {
    
    static var reuseIdentifier: String { get }
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
