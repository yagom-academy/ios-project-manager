//
//  Task+CoreDataClass.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/03.
//
//

import Foundation
import CoreData

@objc(Task)
public final class Task: NSManagedObject, Codable {

    static let entityName = "Task"

    enum State: String, Codable {
        case todo, doing, done
    }

    enum CodingKeys: String, CodingKey {
        case id, title, body, dueDate, state, isRemoved
    }

    public convenience init(from decoder: Decoder) throws {
        let context = CoreDataStack.shared.context
        guard let entity = NSEntityDescription.entity(forEntityName: Task.entityName, in: context) else {
            print("Failed to retrieve managed object context.")
            throw PMError.decodingFailed
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String?.self, forKey: .body)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
        self.state = try container.decode(String.self, forKey: .state)
        self.isRemoved = try container.decode(Bool.self, forKey: .isRemoved)

        try context.save()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(state, forKey: .state)
        try container.encode(isRemoved, forKey: .isRemoved)
    }

    convenience init(context: NSManagedObjectContext,
                     id: UUID = UUID(),
                     title: String,
                     body: String?,
                     dueDate: Date,
                     state: State) {
        self.init(context: context)
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.state = state.rawValue
    }

    convenience init(context: NSManagedObjectContext, responseTask: ResponseTask) {
        self.init(context: context)
        self.id = responseTask.id
        self.title = responseTask.title
        self.body = responseTask.body
        self.dueDate = Date(timeIntervalSince1970: Double(responseTask.dueDate))
        self.state = responseTask.state.rawValue
    }
}
