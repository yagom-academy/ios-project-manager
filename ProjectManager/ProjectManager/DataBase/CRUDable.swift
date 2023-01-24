//
//  CRUDable.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/23.
//

import Foundation

protocol CRUDable {
    
    associatedtype DataType
    
    func create(_ data: DataType)
    
    func read() -> [DataType]
    
    func update(_ data: DataType)
    
    func delete(_ data: DataType)
    
    func deleteAll()
}

protocol ProjectCRUDable: CRUDable where DataType == ProjectViewModel {

}
