import Foundation

extension DateFormatter {
    static let taskListViewStyle: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        
        return dateFormatter
    }()
    
    static func convertToString(from date: Date) -> String {
        let dateFormatter = Self.taskListViewStyle
        return dateFormatter.string(from: date)
    }
}
