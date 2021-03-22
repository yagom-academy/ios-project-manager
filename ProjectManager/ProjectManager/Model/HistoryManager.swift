import Foundation

enum HistoryLog {
    case add(String)
    case move(String, String, String)
    case delete(String)
    
    var description: String {
        switch self {
        case .add(let title):
            return "Added \(title)"
        case .move(let title, let before,  let after):
            return "Moved \(title) from \(before) to \(after)"
        case .delete(let title):
            return "Removed \(title)"
        }
    }
}

class HistoryManager {
    static let shared = HistoryManager()
    
    var historyContainer = [(String, Date)]()
}

let historyManager = HistoryManager.shared
