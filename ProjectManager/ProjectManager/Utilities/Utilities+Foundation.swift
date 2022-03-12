//
//  Utilities+Foundation.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import Foundation

extension Array where Element == Task {
    
    subscript(_ indexSet: IndexSet) -> [Element] {
        indexSet.map { self[$0] }
    }
    
}
