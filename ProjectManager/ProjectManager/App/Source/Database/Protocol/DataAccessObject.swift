//
//  DataAccessObject.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import Foundation

protocol DataAcessObject {
    associatedtype TaskType
    
    var id: UUID { get }
    
    func updateValue(task: TaskType)
}
