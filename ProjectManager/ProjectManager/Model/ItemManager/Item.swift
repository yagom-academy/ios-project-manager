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
