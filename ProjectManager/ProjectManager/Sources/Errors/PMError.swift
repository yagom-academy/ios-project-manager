//
//  PMError.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

enum PMError: Error {

    case invalidAsset
    case decodingFailed
    case invalidTypeIdentifier
    case cannotEncodeToJSON
}

extension PMError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidAsset:
            return "유효하지 않은 파일 이름입니다."
        case .decodingFailed:
            return "디코딩 작업에 실패하였습니다."
        case .invalidTypeIdentifier:
            return "유효하지 않은 Type Identifier입니다."
        case .cannotEncodeToJSON:
            return "JSON으로의 인코딩 작업에 실패하였습니다."
        }
    }
}
