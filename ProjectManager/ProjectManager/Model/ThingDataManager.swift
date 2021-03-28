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
        let fetchRequest = NSFetchRequest<Thing>(entityName: "Thing")
        guard let localThings = try? CoreDataStack.shared.persistentContainer.viewContext.fetch(fetchRequest) else {
            return
        }
        
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
                if onlineThing.id == localThing.id || onlineThing.id == (localThing.id * -1) {
                    if onlineThing.lastModified > localThing.lastModified {
                        // 온라인의 Thing이 최신이어서 로컬 Thing을 삭제
                        CoreDataStack.shared.persistentContainer.viewContext.delete(localThing)
                    } else if onlineThing.lastModified < localThing.lastModified {
                        if localThing.id > 0 {
                            // 로컬 Thing이 최신이어서 온라인 Thing을 갱신
                            NetworkManager.update(thing: localThing) { _ in }
                            CoreDataStack.shared.persistentContainer.viewContext.delete(onlineThing)
                        } else {
                            // 오프라인때 삭제되었지만 온라인에는 남아있을 경우 온라인과 로컬 모두 삭제(오프라인 삭제가 더 최신)
                            let id = localThing.id * -1
                            NetworkManager.delete(id: Int(id)) { _ in }
                            CoreDataStack.shared.persistentContainer.viewContext.delete(localThing)
                            CoreDataStack.shared.persistentContainer.viewContext.delete(onlineThing)
                        }
                    } else {
                        // 온라인과 로컬이 동일하면 온라인에서 가져온 것을 삭제
                        CoreDataStack.shared.persistentContainer.viewContext.delete(onlineThing)
                    }
                    break
                }
            }
        }
        for localThing in localThings {
            if localThing.id == 0 {
                // 오프라인때 생성됐던 Thing을 서버에 저장
                NetworkManager.create(thing: localThing) { result in
                    switch result {
                    case .success(let id):
                        if let id = id {
                            localThing.id = id
                        }
                    case .failure(_):
                        break
                    }
                }
            } else if localThing.id < 0 {
                // 오프라인때 삭제됐던 Thing을 서버와 로컬에서 삭제
                let id = localThing.id * -1
                NetworkManager.delete(id: Int(id)) { _ in }
                CoreDataStack.shared.persistentContainer.viewContext.delete(localThing)
            }
        }
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch {
            debugPrint("core data error")
        }
    }
}
