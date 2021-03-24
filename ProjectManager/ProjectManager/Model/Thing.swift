//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation
import CoreData

class Thing: NSManagedObject, Codable {
    @NSManaged var id: Int32
    @NSManaged var title: String
    @NSManaged var detailDescription: String?
    @NSManaged var dateNumber: Double
    @NSManaged var lastModified: Double
    @NSManaged var state: String?
    var dateString: String {
        return DateFormatter.convertToUserLocaleString(date: date)
    }
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateNumber))
    }
    var parameters: [String : Any] {[
        "id": id,
        "title": title,
        "description": detailDescription ?? String.empty,
        "due_date": dateNumber,
        "updated_at": lastModified,
        "state": state ?? Strings.todoState
    ]}
    
    enum CodingKeys: String, CodingKey {
        case id, title, state
        case detailDescription = "description"
        case dateNumber = "due_date"
        case lastModified = "updated_at"
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: Strings.thing, in: CoreDataStack.shared.persistentContainer.viewContext) else {
            fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: CoreDataStack.shared.persistentContainer.viewContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int32.self, forKey: .id) ?? 0
        self.title = try container.decode(String.self, forKey: .title)
        self.detailDescription = try container.decodeIfPresent(String.self, forKey: .detailDescription)
        self.dateNumber = try container.decodeIfPresent(Double.self, forKey: .dateNumber) ?? 0
        self.lastModified = try container.decode(Double.self, forKey: .lastModified)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(detailDescription, forKey: .detailDescription)
        try container.encode(dateNumber, forKey: .dateNumber)
        try container.encode(lastModified, forKey: .lastModified)
        try container.encode(state, forKey: .state)
    }
}
