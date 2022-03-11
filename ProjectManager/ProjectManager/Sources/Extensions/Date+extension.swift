import Foundation

extension Date {
    static func formattedString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter.string(from: date)
    }
    
    var isPastDeadline: Bool {
        let today = Date()
        let calendar = Calendar.autoupdatingCurrent
        return calendar.compare(today, to: self, toGranularity: .day) == .orderedDescending
    }
}
