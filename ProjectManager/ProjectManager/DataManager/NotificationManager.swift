//
//  NotificationManager.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/30.
//

import UserNotifications

final class NotificationManager {
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        notificationCenter.requestAuthorization(options: notiAuthOptions) { (_, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    func requestSendNoti(with todo: Todo) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = todo.title
        notiContent.body = todo.body
        
        var notiDate = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: todo.date
        )
        notiDate.hour = 9

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: notiDate,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: todo.id.uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        notificationCenter.add(request) { (error) in
            print(#function, error as Any)
        }
    }
    
    func requestCancelNoti(with id: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
}
