//
//  PersistenceManager.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import CoreData

final class PersistenceManager {
    private lazy var persistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var request: NSFetchRequest<ProjectTodoManagedObject> {
        return ProjectTodoManagedObject.fetchRequest()
    }

    private func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchProjectTodos() -> [ProjectTodo] {
        let fetchedObjects = fetch(request: request)
        var projectTodos = [ProjectTodo]()
        projectTodos = fetchedObjects.compactMap { object in
            guard let id = object.id,
                  let state = ProjectState(rawValue: Int(object.state)),
                  let title = object.title,
                  let description = object.todoDescription,
                  let dueDate = object.dueDate else {
                return nil
            }
            return ProjectTodo(id: id, state: state, title: title, description: description, dueDate: dueDate)
        }
        return projectTodos
    }

    func add(_ projectToDo: ProjectTodo) {
        let projectTodoManagedObject = ProjectTodoManagedObject(context: context)
        projectTodoManagedObject.id = projectToDo.id
        projectTodoManagedObject.title = projectToDo.title
        projectTodoManagedObject.state = Int64(projectToDo.state.rawValue)
        projectTodoManagedObject.todoDescription = projectToDo.description
        projectTodoManagedObject.dueDate = projectToDo.dueDate
        saveContext()
    }

    func update(_ projectTodo: ProjectTodo) {
        let fetchedObjects = fetch(request: request)
        guard let projectTodoManagedObject = fetchedObjects.first(where: { $0.id == projectTodo.id }) else { return }
        projectTodoManagedObject.title = projectTodo.title
        projectTodoManagedObject.state = Int64(projectTodo.state.rawValue)
        projectTodoManagedObject.todoDescription = projectTodo.description
        projectTodoManagedObject.dueDate = projectTodo.dueDate
        saveContext()
    }

    func delete(_ projectTodoID: UUID) {
        let fetchedObjects = fetch(request: request)
        guard let projectTodoManagedObject = fetchedObjects.first(where: { $0.id == projectTodoID }) else { return }
        context.delete(projectTodoManagedObject)
        saveContext()
    }
}
