//
//  Todo.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/03/29.
//
import Foundation

struct Todo: Codable {
    let title: String
    let description: String
    let deadline: Double
    
    enum CodingKeys: String, CodingKey {
        case title, description, deadline
    }
    var convertedDate: String {
        return DateFormatter().convertToLocaleDate(deadline)
    }
}
