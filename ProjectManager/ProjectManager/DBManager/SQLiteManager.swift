//
//  SQLiteManager.swift
//  ProjectManager
//
//  Created by JSB on 2023/09/20.
//

import Foundation

class SQLiteManager {
    static let shared: SQLiteManager = SQLiteManager()
    
    var db: OpaquePointer?
    var path: String = "ProjectManagerDB.sqlite"
    
    init() {
        self.db = createDB()
    }
    
    func createDB() -> OpaquePointer? {
        
        return nil
    }
}
