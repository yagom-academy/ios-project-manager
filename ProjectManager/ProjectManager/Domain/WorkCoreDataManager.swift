import Foundation
import CoreData
import RxSwift


private enum Name {
    static let conatainer = "CoreDataModel"
    static let entity = "Work"
}

private enum Content {
    static let predicateFormat = "categoryTag == %d"
    static let saveError = "저장 오류"
}

class WorkCoreDataManager: WorkManagable {
    
    static let shared = WorkCoreDataManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Name.conatainer)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    private let disposeBag = DisposeBag()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var todoList: [Work] {
        sort(for: Work.Category.todo.tag)
    }
    
    var doingList: [Work] {
        sort(for: Work.Category.doing.tag)
    }
    
    var doneList: [Work] {
        sort(for: Work.Category.done.tag)
    }
    
    private init() { }
    
    func create(title: String, body: String, dueDate: Date) {
        let newWork = Work(context: context)
        
        newWork.id = UUID()
        newWork.title = title
        newWork.body = body
        newWork.dueDate = dueDate
        newWork.categoryTag = Work.Category.todo.tag
        
        do {
            try context.save()
        } catch {
            print(Content.saveError)
        }
    }
    
    func delete(_ data: Work) {
        context.delete(data)
        
        do {
            try context.save()
        } catch {
            print(Content.saveError)
        }
    }
    
    func update(_ data: Work, title: String?, body: String?, date: Date?, category: Int16) {
        data.title = title
        data.body = body
        data.dueDate = date
        data.categoryTag = category
        
        do {
            try context.save()
        } catch {
            print(Content.saveError)
        }
    }
    
    private func sort(for categoryTag: Int16) -> [Work] {
        let request = Work.fetchRequest()
        let predicate = NSPredicate(format: Content.predicateFormat, categoryTag)
        request.predicate = predicate
        
        let searchedWorks = try? context.fetch(request)
        
        return searchedWorks ?? []
    }
    
}
