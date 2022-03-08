import Foundation

extension Date {
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    var isPastDeadline: Bool {
        let today = Date()
        let calendar = Calendar.autoupdatingCurrent
        return calendar.compare(today, to: self, toGranularity: .day) == .orderedDescending
    }
}
