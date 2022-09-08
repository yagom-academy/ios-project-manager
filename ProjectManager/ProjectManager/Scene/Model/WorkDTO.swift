//
//  WorkDTO.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

import Foundation

struct WorkDTO: Decodable {
    let id: String
    let title: String
    let body: String
    let date: Date
    let workState: WorkState
    
    private enum CodingKeys: String, CodingKey {
        case id, title, body, date, workState
    }
}
