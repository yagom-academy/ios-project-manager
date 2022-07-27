//
//  NotificationManager.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/27.
//

import UIKit

final class NotificationManager {
    private let notificationCenter: UNUserNotificationCenter
    
    init() {
        self.notificationCenter = UNUserNotificationCenter.current()
    }
    
    func requestAuthorization() {
        self.notificationCenter.requestAuthorization(
            options: [.alert, .sound],
            completionHandler: { didAllow, error  in }
        )
    }

    func setNotification(todoData: Todo) {
        let content = UNMutableNotificationContent()
        content.title = "\(todoData.title)의 마감기한은 \(todoData.date.historyString()) 입니다."
        content.sound = .defaultCritical
        
        var todoDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: todoData.date)
        todoDateComponent.hour = 9
                
        let trigger = UNCalendarNotificationTrigger(dateMatching: todoDateComponent, repeats: false)
        let request = UNNotificationRequest(
            identifier: todoData.identifier.uuidString,
            content: content,
            trigger: trigger
        )
        self.notificationCenter.add(request)
    }

    func deleteNotification(todoIdentifier: String) {
        self.notificationCenter.removePendingNotificationRequests(withIdentifiers: [todoIdentifier])
    }
    
    func updateNotification(todoData: Todo) {
        guard todoData.todoListItemStatus != .done else {
            return deleteNotification(todoIdentifier: todoData.identifier.uuidString)
        }
        self.setNotification(todoData: todoData)
    }
}
