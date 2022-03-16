import Foundation
import RealmSwift

class RealmEntityTask: Object {
    enum ProgressStatus: String {
        case todo
        case doing
        case done
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var deadline: TimeInterval = 0
    @objc dynamic var progressStatus = ProgressStatus.todo.rawValue
    var progressStatusEnum: ProgressStatus {
        get {
            return ProgressStatus(rawValue: progressStatus) ?? .todo
        }
        set {
            progressStatus = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
