import Foundation

enum ProcessStatus: String, Codable, CustomStringConvertible, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var description: String {
        return rawValue
    }
}
