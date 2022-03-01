import Foundation

class WorkList {
    var title: String?
    var body: String?
    var date: Date?
    
    var convertedDate: String {
        guard let currentDate = date else { return "" }
        let dateFormatter = DateFormatter.shared
        
        return dateFormatter.string(from: currentDate)
    }
}
