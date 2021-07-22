//
//  PMError.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/20.
//

import Foundation

enum PMError: Error {
    case invalidAsset
    case decodingFailed
    case invalidTypeIdentifier
    case cannotEncodeToJSON
}
