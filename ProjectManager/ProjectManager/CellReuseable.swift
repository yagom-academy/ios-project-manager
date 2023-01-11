//
//  CellReuseable.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

protocol CellReuseable {
    static var reuseIdentifier: String { get }
}

extension CellReuseable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
