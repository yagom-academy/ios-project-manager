//
//  FakeDataManager.swift
//  ProjectManager
//
//  Created by jin on 1/25/23.
//

import Foundation

final class FakeDataManager {
    static let shared: FakeDataManager = FakeDataManager()
    
    private init() {}
    
    private(set) var tasks: [Task] = []
    
    func create(task: Task) {
        tasks.append(task)
    }
}
