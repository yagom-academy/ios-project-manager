import Foundation

extension Date {
    func formatToString(with templete: String = "yyyy MM dd") -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(templete)
        formatter.locale = NSLocale.current
        return formatter.string(from: self)
    }
}
