import Foundation

enum ProcessStatus: String, Codable, CustomStringConvertible {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var description: String {
        return rawValue
    }
}
