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
            options: [.alert, .badge, .sound],
            completionHandler: { didAllow, error  in }
        )
    }
    
    func setNotification(todo: Todo) {
        let content = UNMutableNotificationContent()
        content.title = todo.title
        content.subtitle = "의 마감기한은 \(todo.date.historyString())입니다. "
        content.badge =  1
        content.sound = .defaultCritical
        
        var todoDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: todo.date)
        todoDateComponent.hour = 9
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: todoDateComponent, repeats: false)
        let request = UNNotificationRequest(
            identifier: todo.identifier.uuidString,
            content: content,
            trigger: timeTrigger
        )
        self.notificationCenter.add(request)
    }
}
