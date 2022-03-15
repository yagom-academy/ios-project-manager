import Foundation

extension String {
    var isNotEmpty: Bool { !isEmpty }

    func formatToDate() -> Date {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd")
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter.date(from: self) ?? Date()
    }
}
