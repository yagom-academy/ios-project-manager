import Foundation

struct Project: Equatable {
    var title: String?
    var body: String?
    var date: TimeInterval
    var state: ProjectState
    let id: UUID
    
    init(title: String?, body: String?, date: TimeInterval) {
        self.title = title
        self.body = body
        self.date = date
        self.state = ProjectState.todo
        self.id = UUID()
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter.shared
        let currentDate = Date(timeIntervalSince1970: date)
        
        return dateFormatter.string(from: currentDate)
    }
    
    var isExpired: Bool {
        let dateFormatter = DateFormatter.shared
        return formattedDate < dateFormatter.string(from: Date())
    }
}
