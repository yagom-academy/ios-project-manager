//
//  ThingDataManager.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/26.
//

import Foundation
import CoreData

final class ThingDataManager {
    static let shared = ThingDataManager()
    private init() {
        todoFetchedResultsController = self.getThingFetchedResultsController("todo")
        doingFetchedResultsController = self.getThingFetchedResultsController("doing")
        doneFetchedResultsController = self.getThingFetchedResultsController("done")
    }
    
    private(set) var todos: [Thing]?
    private(set) var doings: [Thing]?
    private(set) var dones: [Thing]?
    private(set) var todoFetchedResultsController: NSFetchedResultsController<Thing>?
    private(set) var doingFetchedResultsController: NSFetchedResultsController<Thing>?
    private(set) var doneFetchedResultsController: NSFetchedResultsController<Thing>?
    
    private func getThingFetchedResultsController(_ state: String) -> NSFetchedResultsController<Thing> {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Thing> = NSFetchRequest<Thing>(entityName: Strings.thing)
        let predicateFormat = "id >= 0 AND state = '\(state)'"
        fetchRequest.predicate = NSPredicate(format: predicateFormat)
        let sort = NSSortDescriptor(key: #keyPath(Thing.dateNumber), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func setThingFetchedResultsControllerDelegate(_ thingTableView: ThingTableView) {
        switch thingTableView {
        case is TodoTableView:
            todoFetchedResultsController?.delegate = thingTableView
        case is DoingTableView:
            doingFetchedResultsController?.delegate = thingTableView
        case is DoneTableView:
            doneFetchedResultsController?.delegate = thingTableView
        default:
            return
        }
    }
    
    func requestThings() {
        guard let localTodos = fetchThingsFromLocal(Strings.todoState),
              let localDoings = fetchThingsFromLocal(Strings.doingState),
              let localDones = fetchThingsFromLocal(Strings.doneState) else {
            return
        }
        let localThings: [Thing] = localTodos + localDoings + localDones
        
        fetchThingsFromOnline { (result) in
            switch result {
            case .success(let onlineThings):
                self.synchronizeThings(localThings, onlineThings)
            case .failure(_):
                break
            }
            self.broadcastThings(Strings.todoState)
            self.broadcastThings(Strings.doingState)
            self.broadcastThings(Strings.doneState)
        }
    }
    
    private func broadcastThings(_ state: String) {
        guard let things = fetchThingsFromLocal(state) else {
            return
        }
        let notificationName = "broadcast\(state)"
        let userInfo: [String: [Thing]] = [state: things]
        NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: nil, userInfo: userInfo)
    }
    
    private func fetchThingsFromLocal(_ state: String) -> [Thing]? {
        switch state {
        case Strings.todoState:
            do {
                try todoFetchedResultsController?.performFetch()
                return todoFetchedResultsController?.fetchedObjects
            } catch {
                debugPrint("core data error")
            }
        case Strings.doingState:
            do {
                try doingFetchedResultsController?.performFetch()
                return doingFetchedResultsController?.fetchedObjects
            } catch {
                debugPrint("core data error")
            }
        case Strings.doneState:
            do {
                try doneFetchedResultsController?.performFetch()
                return doneFetchedResultsController?.fetchedObjects
            } catch {
                debugPrint("core data error")
            }
        default:
            return nil
        }
        return nil
    }
    
    private func fetchThingsFromOnline(_ completionHandler: @escaping (Result<[Thing], Error>) -> Void) {
        NetworkManager.fetch { result in
            switch result {
            case .success(let things):
                var onlineThings: [Thing] = []
                for thing in things {
                    for t in thing.list {
                        t.state = thing.state
                    }
                    onlineThings.append(contentsOf: thing.list)
                }
                completionHandler(.success(onlineThings))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func synchronizeThings(_ localThings: [Thing], _ onlineThings: [Thing]) {
        for onlineThing in onlineThings {
            for localThing in localThings {
                if localThing.id > 0 && onlineThing.id == localThing.id {
                    if onlineThing.lastModified > localThing.lastModified {
                        // 로컬을 지우고 온라인을 반영
                        CoreDataStack.shared.persistentContainer.viewContext.delete(localThing)
                    } else if onlineThing.lastModified < localThing.lastModified {
                        // 온라인의 내용을 변경
                        NetworkManager.update(thing: localThing) { _ in }
                        CoreDataStack.shared.persistentContainer.viewContext.delete(onlineThing)
                    } else {
                        // 로컬 내용 유지
                        CoreDataStack.shared.persistentContainer.viewContext.delete(onlineThing)
                    }
                    break
                }
            }
        }
        for localTodo in localThings {
            if localTodo.id == 0 {
                // 온라인에 생성
                NetworkManager.create(thing: localTodo) { result in
                    switch result {
                    case .success(let id):
                        if let id = id {
                            localTodo.id = id
                        }
                    case .failure(_):
                        break
                    }
                }
            } else if localTodo.id < 0 {
                // 로컬과 온라인 모두 삭제
                let id = localTodo.id * -1
                NetworkManager.delete(id: Int(id)) { _ in }
                CoreDataStack.shared.persistentContainer.viewContext.delete(localTodo)
            }
        }
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            debugPrint("core data error")
        }
    }
}
