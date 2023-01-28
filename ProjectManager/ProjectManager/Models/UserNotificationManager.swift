//
//  UserNotificationManager.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import UserNotifications

final class UserNotificationManager {
    private let userNotificationCenter = UNUserNotificationCenter.current()

    private func makeNotificationContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        return content
    }

    private func makeNotificationTrigger(date: Date) -> UNCalendarNotificationTrigger {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = Constants.notificationHour
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }

    func registerNotification(identifier: UUID, title: String, dueDate: Date) {
        guard dueDate.isEarlierThanToday() == false else { return }
        let content = makeNotificationContent(title: title, body: dueDate.localizedDateString())
        let trigger = makeNotificationTrigger(date: dueDate)
        let request = UNNotificationRequest(identifier: identifier.uuidString, content: content, trigger: trigger)
        userNotificationCenter.add(request) { error in
            if let error {
                print(error.localizedDescription)
            }
        }
    }

    func removeNotification(with identifier: UUID) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier.uuidString])
    }

    func updateNotification(identifier: UUID, title: String, dueDate: Date) {
        removeNotification(with: identifier)
        registerNotification(identifier: identifier, title: title, dueDate: dueDate)
    }
}
