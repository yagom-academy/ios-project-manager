//
//  PopNotificationSendable.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/27.
//

import Foundation

protocol PopNotificationSendable {
    func sendNotificationForHistory()
}

extension PopNotificationSendable {
    func sendNotificationForHistory() {
        NotificationCenter.default.post(
            name: NSNotification.Name(AppConstants.popHistoryNotificationName),
            object: nil,
            userInfo: nil
        )
    }
}
