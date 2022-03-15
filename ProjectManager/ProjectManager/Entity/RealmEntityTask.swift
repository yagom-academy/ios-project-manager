import Foundation
import RealmSwift

class RealmEntityTask: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var deadline: TimeInterval = 0
    @objc dynamic var progressStatus: String = ""
}
