import Foundation

struct Thing: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let state: State?
    let dueDate: Double?
    let updatedAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, state
        case dueDate = "due_date"
        case updatedAt = "updated_at"
    }
}
