//
//  ReusableCell.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/17.
//

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
