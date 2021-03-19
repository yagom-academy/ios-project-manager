//
//  Thing.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/09.
//

import Foundation
import CoreData

class Thing: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id, title, state
        case detailDescription = "description"
        case dateNumber = "due_date"
    }
    
    @NSManaged var id: Int32
    @NSManaged var title: String?
    @NSManaged var detailDescription: String?
    @NSManaged var dateNumber: Int64
    @NSManaged var state: String?
    
    required convenience init(from decoder: Decoder) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Thing", in: CoreDataStack.shared.persistentContainer.viewContext) else {
            fatalError("Failed to decode User")
        }
        self.init(entity: entity, insertInto: CoreDataStack.shared.persistentContainer.viewContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int32.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.detailDescription = try container.decodeIfPresent(String.self, forKey: .detailDescription)
        self.dateNumber = try container.decodeIfPresent(Int64.self, forKey: .dateNumber) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(detailDescription, forKey: .detailDescription)
        try container.encode(dateNumber, forKey: .dateNumber)
        try container.encode(state, forKey: .state)
    }
    
    var isDone: Bool = false
    var dateString: String {
        return DateFormatter().convertToUserLocaleString(date: date)
    }
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dateNumber))
    }
    
    
}
