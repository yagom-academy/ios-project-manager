import Foundation

extension TimeInterval {
    func formatString(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = Locale(identifier: localeID ?? "ko-kr").languageCode
        dateFormatter.locale = Locale(identifier: deviceLocale ?? "ko-kr")
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
