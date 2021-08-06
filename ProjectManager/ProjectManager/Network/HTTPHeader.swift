//
//  HTTPHeader.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/08/06.
//

import Foundation

enum HTTPHeader {
    case contentType(key: String)
    
    var header: [String: String] {
        switch self {
        case .contentType(let key):
            return ["Content-Type": key]
        }
    }
    
    static let applicationJson = "application/json"
}
