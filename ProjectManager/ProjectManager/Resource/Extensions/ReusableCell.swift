//
//  ReusableCell.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/14.
//

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}
