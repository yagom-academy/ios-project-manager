//
//  Argument.swift
//  ProjectManager
//
//  Created by Max on 2023/09/26.
//

import Foundation

final class KeywordArgument {
    let key: String
    let value: Any?
    
    init(key: String, value: Any?) {
        self.key = key
        self.value = value
    }
    
}
