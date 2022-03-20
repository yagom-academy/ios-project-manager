//
//  RemoteDataManagable.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/20.
//

import Foundation

protocol RemoteDataManagable: AnyObject {
    
    associatedtype Item

    func create(with content: [String: Any])
        
    func read(
        of identifier: String,
        completion: @escaping (Result<[String: Any], FirestoreError>) -> Void)
        
    func update(of identifier: String, with content: [String: Any])
        
    func delete(of identifier: String)
    
}
