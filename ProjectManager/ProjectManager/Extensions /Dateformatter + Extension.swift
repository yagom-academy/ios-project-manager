import Foundation

extension DateFormatter {
    
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter
    }()
}


