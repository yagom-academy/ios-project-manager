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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return realmEntityTaskList
    }
    
    func updateTask(id: String, title: String, description: String, deadline: Date) {
        do {
            let realm = try Realm()
            let task = realm.objects(RealmEntityTask.self)
                .filter { $0.id == id }
            try realm.write {
                task.first?.title = title
                task.first?.desc = description
                task.first?.deadline = deadline.timeIntervalSince1970
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateTaskState(id: String, progressStatus: RealmEntityTask.ProgressStatus) {
        do {
            let realm = try Realm()
            let task = realm.objects(RealmEntityTask.self)
                .filter { $0.id == id }
            try realm.write {
                task.first?.progressStatus = progressStatus.rawValue
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteTask(id: String) {
        do {
            let realm = try Realm()
            let task = realm.objects(RealmEntityTask.self)
                .filter { $0.id == id }
            try realm.write {
                realm.delete(task.first ?? task[0])
            }
        } catch let error {
            print(error)
        }
    }
}
