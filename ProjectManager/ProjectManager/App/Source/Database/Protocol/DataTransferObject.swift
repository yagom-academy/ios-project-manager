//
//  DataTransferObject.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

protocol DataTransferObject: Codable {
    var id: UUID { get }
}
