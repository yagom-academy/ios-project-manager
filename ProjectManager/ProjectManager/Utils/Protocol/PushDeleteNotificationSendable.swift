//
//  PushDeleteNotificationSendable.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/28.
//

import Foundation

protocol PushDeleteNotificationSendable {
    func sendNotificationForHistory()
}

extension PushDeleteNotificationSendable {
    func sendNotificationForHistory(_ title: String, from type: TaskType) {
        let content = "Removed '\(title)' from \(type.rawValue)"
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = ["content": content, "time": time]
        NotificationCenter.default.post(name: NSNotification.Name("PushHistory"), object: nil, userInfo: history)
    }
}
