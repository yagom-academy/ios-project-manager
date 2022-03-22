//
//  TextError.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/15.
//

import Foundation

enum TextError: Error {
    case invalidTitle
    case invalidDescription
    case invalidTitleAndDescription
    case outOfBounds(Int)
}

extension TextError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "제목을 입력해주세요"
        case .invalidDescription:
            return "내용을 입력해주세요"
        case .invalidTitleAndDescription:
            return "제목, 내용을 입력해주세요"
        case .outOfBounds(let length):
            return "\(length)글자 미만으로 입력해주세요"
        }
    }
}
