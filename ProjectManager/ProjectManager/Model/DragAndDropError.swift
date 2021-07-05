//
//  Error.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/02.
//

import Foundation

enum DragAndDropError: Error {
    case invalidTypeIdentifier
    case invalidFormatType
    case jsonParsingError
}
