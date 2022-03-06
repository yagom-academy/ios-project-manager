import Foundation

class DataBaseChecker {
    
    static var currentDataBase: DatabaseType = .Mock
    
    private init() {
        
    }
    
    static func switchDataBase(to database: DatabaseType) {
        DataBaseChecker.currentDataBase = database
    }
}
