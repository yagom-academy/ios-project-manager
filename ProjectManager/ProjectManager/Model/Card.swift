//
//  Card.swift
//  ProjectManager
//
//  Created by Kyungmin Lee on 2021/04/05.
//

import Foundation

class Card: Codable {
    var id: Int?
    var title: String
    var description: String?
    var deadline: Int?
    var status: String?
}
