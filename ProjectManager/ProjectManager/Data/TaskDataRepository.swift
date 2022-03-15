import CoreData

protocol TaskRepository {
    func saveContext()

    func create(taskListModel: TaskListModel, completed: @escaping (Bool) -> Void)
    func read(completed: @escaping ([TaskListModel]) -> Void)
    func update(taskListModel: TaskListModel, completed: @escaping (Bool) -> Void)
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

    func create(taskListModel: TaskListModel, completed: @escaping (Bool) -> Void) {
        let taskListModel = TaskListModel(title: taskListModel.title, items: taskListModel.items)
        let fetchedRequest = TaskDataModel.fetchTaskRequest(with: taskListModel.id)
        guard fetchedRequest.isNotInclude(input: taskListModel.id) else {
            completed(false)
            return
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "TaskDataModel", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        setValue(to: managedObject, with: taskListModel)
        save(completed: completed)
    }

    func read(completed: @escaping ([TaskListModel]) -> Void) {
        let convertedEntity = fetchedObjects.compactMap { dataModel in convertToEntity(from: dataModel) }
        completed(convertedEntity)
    }

    func update(taskListModel: TaskListModel, completed: @escaping (Bool) -> Void) {
        let fetchedRequest = TaskDataModel.fetchTaskRequest(with: taskListModel.id)
        guard fetchedRequest.isNotInclude(input: taskListModel.id) else {
            completed(false)
            return
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "TaskDataModel", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        setValue(to: managedObject, with: taskListModel)
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

    private func setValue(to object: NSManagedObject, with taskListModel: TaskListModel) {
        let managedObject = object
        [
            "id": taskListModel.id,
            "title": taskListModel.title,
            "items": taskListModel.items
        ].forEach { key, value in
            managedObject.setValue(value, forKey: key)
        }
    }

    private func convertToEntity(from dataModel: TaskDataModel) -> TaskListModel {
        var convertedItems = [TaskModel]()
        dataModel.items.forEach { item in
            convertedItems.append(TaskModel(title: item.title,
                                            body: item.body,
                                            dueDate: item.dueDate,
                                            lastModifiedDate: item.lastModifiedDate))
        }
        return TaskListModel(id: dataModel.id, title: dataModel.title, items: convertedItems)
    }
}
