//
//  TODOModel.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/30.
//

import Foundation

struct Task: Codable {
    var title: String
    var date: Double
    var description: String
    var status: String
    let identifier: String
}
