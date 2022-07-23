//
//  Todo+Serializable.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/23.
//

protocol Serializable {
    var dictionary: [String: Any] { get }
    init?(dictionary: [String: Any])
}
