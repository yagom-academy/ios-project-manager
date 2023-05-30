//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import Foundation

final class WorkViewModel {
    struct Work: Hashable {
        let id: UUID = UUID()
        var status: String = WorkStatus.todo.title
        var title: String
        var body: String
        var deadline: Date
    }
    
    enum WorkStatus: CaseIterable {
        case todo
        case doing
        case done
        
        var title: String {
            switch self {
            case .todo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
        
        var movedButtonName: (top: String, bottom: String) {
            switch self {
            case .todo:
                return (top: "Move to DOING", bottom: "Move to DONE")
            case .doing:
                return (top: "Move to TODO", bottom: "Move to DONE")
            case .done:
                return (top: "Move to TODO", bottom: "Move to DOING")
            }
        }
    }

    enum ViewMode {
        case add
        case edit
    }
    
    var works: [Work] = []
    var currentID: UUID?
    
    func fetchWorkIndex() -> Int? {
        guard let index = works.firstIndex(where: { $0.id == currentID }) else { return nil }
        
        return index
    }
    
    func fetchWork() -> Work? {
        guard let index = fetchWorkIndex() else { return nil }
        
        return works[index]
    }
    
    func addWork(title: String, body: String, deadline: Date) {
        works.append(Work(title: title, body: body, deadline: deadline))
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func updateWork(title: String, body: String, deadline: Date) {
        guard let index = fetchWorkIndex() else { return }
        
        works[index].title = title
        works[index].body = body
        works[index].deadline = deadline
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func removeWork() {
        guard let index = fetchWorkIndex() else { return }
        
        works.remove(at: index)
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func moveStatus(to status: WorkStatus) {
        guard let index = fetchWorkIndex() else { return }
        
        works[index].status = status.title
        NotificationCenter.default.post(name: .updateSnapShot, object: nil)
    }
    
    func fetchWorkCount(of status: WorkStatus) -> Int {
        let filteredWorks = works.filter { $0.status == status.title }
        
        return filteredWorks.count
    }
    
    func checkExceededDeadline(_ targetDate: Date) -> Bool {
        return targetDate < Date() ? true : false
    }
}
