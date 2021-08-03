//
//  ServerAPI.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/08/03.
//

import Foundation

enum ServerAPI {
    static let baseURL = "https://projectmanager-great.herokuapp.com/tasks"
    
    case create
    case read
    case update(id: String)
    case delete(id: String)

    var url: URL? {
        switch self {
        case .create:
            return URL(string: Self.baseURL)
        case .read:
            return URL(string: Self.baseURL)
        case .update(let id):
            return URL(string: Self.baseURL + "/" + id)
        case .delete(let id):
            return URL(string: Self.baseURL + "/" + id)
        }
    }
}
