//
//  NetworkError.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/15.
//

import Foundation

enum NetworkError: Error {
    case connectionProblem
    case decodingProblem
    case invalidData
    case invalidRequest
    case invalidResponse
}
