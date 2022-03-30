import Foundation


extension DateFormatter {
    
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter
    }()
    
    static let common: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        return dateFormatter
    }()

}
