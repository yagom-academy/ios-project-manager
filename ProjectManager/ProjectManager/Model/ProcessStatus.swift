import Foundation

enum ProcessStatus: String, Codable, CustomStringConvertible, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var description: String {
        return rawValue
    }
    
    var processStatusChangeOption: [Self] {
        return ProcessStatus.allCases.filter { $0 != self }
    }
}
