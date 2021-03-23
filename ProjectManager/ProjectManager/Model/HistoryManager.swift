import Foundation

class HistoryManager {
    static let shared = HistoryManager()
    
    var historyContainer = [(HistoryLog, Date)]()
}

let historyManager = HistoryManager.shared
