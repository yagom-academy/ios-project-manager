import Foundation

extension DateFormatter {
    static let shared: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        return dateFormatter
    }()
}
