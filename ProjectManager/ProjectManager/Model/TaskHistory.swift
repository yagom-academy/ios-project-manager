import Foundation

struct TaskHistory: Identifiable {
    var description: String
    var date: TimeInterval
    
    var id: UUID { UUID() }
}
