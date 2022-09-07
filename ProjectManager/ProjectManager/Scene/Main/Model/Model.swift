//
//  Model.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/07.
//

import Foundation

struct Model: Hashable {
    private let uuid = UUID()
    let title: String
    let body: String
    let date: String
}
