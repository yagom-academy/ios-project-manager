//  ProjectManager - HistoryViewModel.swift
//  created by zhilly on 2023/01/27

import Foundation

final class HistoryViewModel {
    let model: Observable<[History]> = Observable([])
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appendDeletedHistory(_:)),
                                               name: NSNotification.Name.deleted,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appendAddedHistory(_:)),
                                               name: NSNotification.Name.added,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appendMovedHistory(_:)),
                                               name: NSNotification.Name.moved,
                                               object: nil)
    }
    
    @objc
    func appendDeletedHistory(_ notification: Notification) {
        guard let data = notification.userInfo,
              let deletedTitle = data["Title"] as? String,
              let from = data["State"] as? String else {
            return
        }
        
        let title = "Removed '\(deletedTitle)' from \(from)."
        let history = History(title: title,
                              createdAt: DateFormatter.convertToFullString(to: Date()))
        
        model.value.insert(history, at: 0)
    }
    
    @objc
    func appendAddedHistory(_ notification: Notification) {
        guard let data = notification.userInfo,
              let addedTitle = data["Title"] as? String else {
            return
        }
        
        let title = "Added '\(addedTitle)'."
        let history = History(title: title,
                              createdAt: DateFormatter.convertToFullString(to: Date()))
        
        model.value.insert(history, at: 0)
    }
    
    @objc
    func appendMovedHistory(_ notification: Notification) {
        guard let data = notification.userInfo,
              let deletedTitle = data["Title"] as? String,
              let pastState = data["PastState"] as? String,
              let currentState = data["CurrentState"] as? String else {
            return
        }
        
        let title = "Moved '\(deletedTitle)' from \(pastState) to \(currentState)."
        let history = History(title: title,
                              createdAt: DateFormatter.convertToFullString(to: Date()))
        
        model.value.insert(history, at: 0)
    }
}
