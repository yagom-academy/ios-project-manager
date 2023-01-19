//
//  CellReusable.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
