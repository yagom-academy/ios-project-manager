//
//  NetworkError.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/08/03.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidStatusCode(_ code: Int)
    case emptyData
    case decodingError
    case error
    case invalidRequest
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidResponse:
            return "invalidResponse"
        case .invalidStatusCode(let code):
            return "invalidStatusCode \(code)"
        case .emptyData:
            return "emptyData"
        case .decodingError:
            return "decoding Error"
        case .invalidRequest:
            return "invalidRequest"
        case .error:
            return "error"
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.invalidStatusCode(let left), .invalidStatusCode(let right)):
            return left == right
        default:
            break
        }
        return String(reflecting: lhs) == String(reflecting: rhs)
    }
}
