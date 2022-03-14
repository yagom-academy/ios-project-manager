import CoreData

protocol TaskRepository {
    func saveContext()

    func create(taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskListEntity]) -> Void)
    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void)
    func delete(by id: UUID, completed: @escaping (Bool) -> Void)
}

final class TaskDataRepository: TaskRepository {
    private lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "TaskDataModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                #if DEBUG
                print("Unresolved error \(error), \(error.userInfo)")
                #endif
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private(set) lazy var controller = NSFetchedResultsController(
        fetchRequest: TaskDataModel.fetchTaskRequest(),
        managedObjectContext: self.context,
        sectionNameKeyPath: nil,
        cacheName: nil)

    var fetchedObjects: [TaskDataModel] { controller.fetchedObjects ?? [] }

    init() {
        try? controller.performFetch()
    }

    func save(completed: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            self.saveContext()
            DispatchQueue.main.async {
                completed(true)
            }
        }
    }

    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                #if DEBUG
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif
            }
        }
    }

    func create(taskList: TaskListEntity, completed: @escaping (Bool) -> Void) {
        let taskList = TaskListEntity(title: taskList.title, items: taskList.items)
        let fetchedRequest = TaskDataModel.fetchTaskRequest(with: taskList.id)
        guard fetchedRequest.isNotInclude(input: taskList.id) else {
            completed(false)
            return
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "TaskDataModel", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        setValue(to: managedObject, with: taskList)
        save(completed: completed)
    }

    func read(completed: @escaping ([TaskListEntity]) -> Void) {
        let convertedTasks = fetchedObjects.compactMap { dataModel in
            convertDataModelToEntity(dataModel: dataModel) }
        completed(convertedTasks)
    }

    func update(taskList: TaskListEntity, completed: @escaping (Bool) -> Void) {
        let fetchedRequest = TaskDataModel.fetchTaskRequest(with: taskList.id)
        guard fetchedRequest.isNotInclude(input: taskList.id) else {
            completed(false)
            return
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "TaskDataModel", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        setValue(to: managedObject, with: taskList)
        save(completed: completed)
    }

    func delete(by id: UUID, completed: @escaping (Bool) -> Void) {
        let fetchedRequest = TaskDataModel.fetchTaskRequest(with: id)
        guard fetchedRequest.isNotInclude(input: id) else {
            completed(false)
            return
        }

        do {
            let filteredResults = try context.fetch(fetchedRequest)
            guard let filteredResult = filteredResults.first else { return }
            context.delete(filteredResult)
        } catch {
            completed(false)
            return
        }
        save(completed: completed)
    }

    private func setValue(to object: NSManagedObject, with taskList: TaskListEntity) {
        let managedObject = object
        [
            "id": taskList.id,
            "title": taskList.title,
            "items": taskList.items
        ].forEach { key, value in
            managedObject.setValue(value, forKey: key)
        }
    }

    private func convertDataModelToEntity(dataModel: TaskDataModel) -> TaskListEntity {
        var convertedItems = [TaskEntity]()
        dataModel.items.forEach { item in
            convertedItems.append(TaskEntity(title: item.title,
                                             dueDate: item.dueDate,
                                             body: item.body,
                                             lastModifiedDate: item.lastModifiedDate))
        }
        return TaskListEntity(title: dataModel.title, id: dataModel.id, items: convertedItems)
    }
}
