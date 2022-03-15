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
    
    func fetch() -> [RealmEntityTask] {
        var realmEntityTaskList = [RealmEntityTask]()
        
        do {
            let realm = try Realm()
            let fetchDataList = realm.objects(RealmEntityTask.self)
            fetchDataList
                .forEach {
                    realmEntityTaskList.append($0)
                }
        } catch let error {
            print(error)
        }
        
        return realmEntityTaskList
    }
}
