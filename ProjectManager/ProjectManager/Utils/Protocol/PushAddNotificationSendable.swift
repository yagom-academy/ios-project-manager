//
//  PushAddNotificationSendable.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/28.
//

import Foundation

protocol PushAddNotificationSendable {
    func sendNotificationForHistory()
}

extension PushAddNotificationSendable {
    func sendNotificationForHistory(_ title: String) {
        let content = "Added '\(title)'."
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = ["content": content, "time": time]
        NotificationCenter.default.post(name: NSNotification.Name("PushHistory"), object: nil, userInfo: history)
    }
}
