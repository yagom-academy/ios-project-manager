import Foundation
import RealmSwift

class RealmTaskListRepository {
    
    func createEntityTask(task: RealmEntityTask) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(task)
            }
        } catch let error {
            print(error)
        }
    }
}
