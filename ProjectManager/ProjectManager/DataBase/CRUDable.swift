//
//  CRUDable.swift
//  ProjectManager
//
//  Created by 써니쿠키 on 2023/01/23.
//

import Foundation

// MARK: - CRUDable Base Protocol
protocol CRUDable {
    
    associatedtype DataType
    
    func create(_ data: DataType)
    
    func read() -> [DataType]
    
    func update(_ data: DataType)
    
    func delete(_ data: DataType)
    
    func deleteAll()
}

// MARK: - CRUDable 타입지정: ProjectViewModel
protocol ProjectCRUDable: CRUDable where DataType == ProjectViewModel {

}

// MARK: - RemoteDataBase용 ProjectCRUDable
protocol ProjectRemoteCRUDable: ProjectCRUDable {
    
    func updateAfterNetworkConnection(projectViewModels: [ProjectViewModel])
}
