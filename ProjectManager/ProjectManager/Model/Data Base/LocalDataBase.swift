//
//  LocalDataManagable.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

protocol LocalDataBase {
    
    associatedtype Item

    func create()
        
    func read<T: Hashable>(of identifier: T) -> Item?
        
    func update<T: Hashable>(of identifier: T, with content: [String: Any])
        
    func delete<T: Hashable>(of identifier: T)
    
}
