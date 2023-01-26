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
                              createdAt: DateFormatter.convertToString(to: Date(), style: .full))
        
        model.value.insert(history, at: 0)
    }
}
