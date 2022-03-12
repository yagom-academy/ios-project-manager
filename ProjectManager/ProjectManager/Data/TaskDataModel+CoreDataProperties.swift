import Foundation
import CoreData


extension TaskDataModel {
    @nonobjc public class func fetchTaskRequest() -> NSFetchRequest<TaskDataModel> {
        return NSFetchRequest<TaskDataModel>(entityName: "TaskDataModel")
    }

    @nonobjc public class func fetchTaskRequest(with id: UUID) -> NSFetchRequest<TaskDataModel> {
        let fetchRequest = TaskDataModel.fetchTaskRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        return fetchRequest
    }

    @nonobjc public class func fetchSortedTaskRequest() -> NSFetchRequest<TaskDataModel> {
        let fetchRequest = TaskDataModel.fetchTaskRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
        return fetchRequest
    }

    @NSManaged public var id: UUID
    @NSManaged public var items: [TaskEntity]
    @NSManaged public var title: String
}
