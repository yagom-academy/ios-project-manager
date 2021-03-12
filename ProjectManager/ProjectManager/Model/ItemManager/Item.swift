import Foundation

struct Item: Codable {
    var title: String
    var description: String
    var progressStatus: String
    var dueDate: Int
    
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dueDate))
    }
    
    var dateToString: String {
        return DateFormatter().convertDateToString(date: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, progressStatus, dueDate
    }
    
    mutating func updateItem(_ item: Item) {
        self.title = item.title
        self.description = item.description
        self.progressStatus = item.progressStatus
        self.dueDate = item.dueDate
    }
}

extension DateFormatter {
    func convertDateToString(date: Date) -> String {
        let currentLocale = Locale.current.collatorIdentifier ?? "ko_KR"
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: currentLocale)
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
}
