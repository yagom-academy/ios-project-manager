//
//  ProjectManager - Projects.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

import Foundation

final class Projects {
    static let shared = Projects()
    
    private init() { }
    
    var list = [Project]()
}
