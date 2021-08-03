//
//  HttpMethod.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/08/03.
//

import Foundation
 
enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
    
