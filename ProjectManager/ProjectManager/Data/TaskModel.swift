import Foundation

@objc(TaskModel)
public class TaskModel: NSObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public var id: UUID = UUID()
    var title: String = ""
    var body: String = ""
    var dueDate: Date = Date()
    var lastModifiedDate: Date = Date()
    var creationDate: Date = Date()
    
    init(id: UUID = UUID(),
         title: String,
         body: String,
         dueDate: Date,
         lastModifiedDate: Date = Date(),
         creationDate: Date = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.lastModifiedDate = lastModifiedDate
        self.creationDate = creationDate
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(body, forKey: "body")
        coder.encode(dueDate, forKey: "dueDate")
        coder.encode(lastModifiedDate, forKey: "lastModifiedDate")
        coder.encode(creationDate, forKey: "creationDate")
    }
    
    public required init?(coder: NSCoder) {
        super.init()
        
        guard let decodedId = coder.decodeObject(forKey: "id") as? UUID else { return }
        guard let decodedTitle = coder.decodeObject(forKey: "title") as? String else { return }
        guard let decodedBody = coder.decodeObject(forKey: "body") as? String else { return }
        guard let decodedDueDate = coder.decodeObject(forKey: "dueDate") as? Date else { return }
        guard let decodedLastModifiedDate = coder.decodeObject(forKey: "lastModifiedDate") as? Date else { return }
        guard let decodedCreationDate = coder.decodeObject(forKey: "creationDate") as? Date else { return }

        id = decodedId
        title = decodedTitle
        body = decodedBody
        dueDate = decodedDueDate
        lastModifiedDate = decodedLastModifiedDate
        creationDate = decodedCreationDate
    }
}

@objc(NSTaskModelTransformer)
class NSTaskModelTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [TaskModel.self]
    }
}
