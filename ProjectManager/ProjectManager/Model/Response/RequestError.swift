//
//  RequestError.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation

struct RequestError: Decodable {
    let reason: String
    let error: Bool
}
