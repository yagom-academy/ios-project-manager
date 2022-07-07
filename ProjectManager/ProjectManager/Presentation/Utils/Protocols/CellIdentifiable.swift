//
//  CellIdentifiable.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation

protocol CellIdentifiable {}

extension CellIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
