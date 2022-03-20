//
//  LocalDataManagable.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

protocol LocalDataManagable {
    
    associatedtype Item

    func create(with content: [String: Any])
        
    func read<T: Hashable & CustomStringConvertible>(of identifier: T) -> Item?
        
    func update<T: Hashable & CustomStringConvertible>(of identifier: T, with content: [String: Any])
        
    func delete<T: Hashable & CustomStringConvertible>(of identifier: T)
    
}
