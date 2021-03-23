import Foundation

enum HistoryLog: CustomStringConvertible {
    case add(String)
    case move(String, String, String)
    case delete(String, String)
    
    var description: String {
        switch self {
        case .add(let title):
            return "Added '\(title)'."
        case .move(let title, let before,  let after):
            return "Moved '\(title)' from \(before) to \(after)."
        case .delete(let title, let before):
            return "Removed '\(title)' from \(before)."
        }
    }
}
