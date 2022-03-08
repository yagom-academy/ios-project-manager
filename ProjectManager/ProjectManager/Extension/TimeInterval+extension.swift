import Foundation

extension TimeInterval {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
