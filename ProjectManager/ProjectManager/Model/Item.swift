import Foundation

struct Item: Codable {
    var title: String
    var description: String
    var progressStatus: String
    var timeStamp: Int
    var dueDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(timeStamp))
    }
    var dateToString: String {
        return DateFormatter().convertDateToString(date: dueDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, progressStatus, timeStamp
    }
    
    mutating func updateItem(_ item: Item) {
        self.title = item.title
        self.description = item.description
        self.progressStatus = item.progressStatus
        self.timeStamp = item.timeStamp
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
