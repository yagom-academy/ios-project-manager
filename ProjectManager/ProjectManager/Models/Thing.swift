import Foundation

final class Thing: NSObject, Codable {
    var id: Int? = nil
    var title: String? = nil
    var des: String? = nil
    var state: State? = nil
    var dueDate: Double? = nil
    var updatedAt: Double? = nil
    
    init(id: Int, title: String?, description: String?, state: State, dueDate: Double, updatedAt: Double) {
        self.id = id
        self.title = title
        self.des = description
        self.state = state
        self.dueDate = dueDate
        self.updatedAt = updatedAt
    }
    
    init(title: String?, description: String?, state: State?, dueDate: Double?) {
        self.title = title
        self.des = description
        self.state = state
        self.dueDate = dueDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, des, state
        case dueDate = "due_date"
        case updatedAt = "updated_at"
    }
    
    static func ==(lhs: Thing, rhs: Thing) -> Bool {
        return lhs.id == rhs.id
    }
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? Thing else { return false }
        return self.id == object.id
    }
}

//MARK: - NSItemProviderWriting -
extension Thing: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return ["com.holuck"]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
          do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
          } catch {
            completionHandler(nil, error)
          }
          return progress
    }
}

//MARK: - NSItemProviderReading -
extension Thing: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return ["com.holuck"]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Thing {
        let decoder = JSONDecoder()
        do {
            let subject = try decoder.decode(Thing.self, from: data)
            return subject
        } catch {
            fatalError("\(error)")
        }
    }
}
