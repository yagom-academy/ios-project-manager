import Foundation
import RealmSwift

class RealmTaskListRepository {
    
    func syncTask(_ task: RealmEntityTask) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(task, update: .modified)
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetch() throws -> [RealmEntityTask] {
        var realmEntityTaskList = [RealmEntityTask]()
        let realm = try Realm()
        let fetchDataList = realm.objects(RealmEntityTask.self)
        fetchDataList
            .forEach {
                realmEntityTaskList.append($0)
            }
        
        return realmEntityTaskList
    }
    
    func createEntityTask(task: RealmEntityTask) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(task)
        }
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) throws {
        let realm = try Realm()
        let task = realm.objects(RealmEntityTask.self)
            .filter { $0.id == id }
        try realm.write {
            task.first?.title = title
            task.first?.desc = description
            task.first?.deadline = deadline.timeIntervalSince1970
        }
    }
    
    func updateTaskStatus(id: String, taskStatus: TaskStatus) throws {
        let realm = try Realm()
        let task = realm.objects(RealmEntityTask.self)
            .filter { $0.id == id }
        try realm.write {
            task.first?.progressStatus = taskStatus.rawValue
        }
    }
    
    func deleteTask(id: String) throws {
        let realm = try Realm()
        let task = realm.objects(RealmEntityTask.self)
            .filter { $0.id == id }
        try realm.write {
            realm.delete(task.first ?? task[0])
        }
    }
}
