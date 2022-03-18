import CoreData

extension TaskDataModel {
    @nonobjc public class func fetchTaskRequest() -> NSFetchRequest<TaskDataModel> {
        let fetchRequest = NSFetchRequest<TaskDataModel>(entityName: "TaskDataModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastModifiedDate", ascending: false)]
        return fetchRequest
    }

    @nonobjc public class func fetchTaskRequest(with id: UUID) -> NSFetchRequest<TaskDataModel> {
        let fetchRequest = TaskDataModel.fetchTaskRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        return fetchRequest
    }

    @NSManaged public var id: UUID
    @NSManaged public var items: [TaskModel]
    @NSManaged public var title: String
    @NSManaged public var lastModifiedDate: Date
}
