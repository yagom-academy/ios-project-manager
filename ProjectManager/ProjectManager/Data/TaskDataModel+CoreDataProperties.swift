import Foundation
import CoreData


extension TaskDataModel {
    @nonobjc public class func fetchTaskRequest() -> NSFetchRequest<TaskDataModel> {
        return NSFetchRequest<TaskDataModel>(entityName: "TaskDataModel")
    }

    @nonobjc public class func fetchSortedNoteRequest() -> NSFetchRequest<TaskDataModel> {
        let fetchRequest = TaskDataModel.fetchTaskRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
        return fetchRequest
    }

    @NSManaged public var id: UUID
    @NSManaged public var items: [TaskEntity]
    @NSManaged public var title: String
}
