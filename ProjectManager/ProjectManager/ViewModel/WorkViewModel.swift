//
//  WorkViewModel.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

import Foundation

final class WorkViewModel {
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
        if targetDate < Date() {
            return true
        } else {
            return false
        }
    }
}
