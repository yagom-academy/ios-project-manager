//
//  DataSource.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/22.
//

import Foundation

protocol DataSource: AnyObject {

    func create(with content: [String: Any])
        
    func read(
        of identifier: String,
        completion: @escaping (Result<Project?, Error>) -> Void
    )
    
    func read(
        of group: Status,
        completion: @escaping (Result<[Project]?, Error>) -> Void
    )
    
    func updateContent(of identifier: String, with content: [String: Any])
    
    func updateStatus(of identifier: String, with status: Status)
        
    func delete(of identifier: String)
}

