import Foundation

struct Item: Codable {
    let title: String
    let description: String
    let progressStatus: String
    let dueDate: Int
    
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
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: currentLocale)
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy. MM. dd.")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter.string(from: date)
    }
}
