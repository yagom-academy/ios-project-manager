import Foundation

class HistoryManager {
    static let shared = HistoryManager()
    
    var historyContainer = [(String, Date)]()
}

let historyManager = HistoryManager.shared
