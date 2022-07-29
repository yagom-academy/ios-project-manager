//
//  UserNotificationManager.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/29.
//

import Foundation
import UserNotifications

struct UserNotificationManager {
    
    fileprivate enum Constants {
        static let secondsOfDay: Double = 86400
        static let userNotificationTitle: String = "오늘까지인 일정이 있습니다."
        static let userNotificationHour: Int = 9
    }
    
    func addUserNotification(of task: Task) {
        guard todayIsDeadline(of: task) else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = Constants.userNotificationTitle
        content.body = task.title
        content.subtitle = task.taskType.rawValue
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = Constants.userNotificationHour
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request =  UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeUserNotification(of task: Task) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id])
    }
    
    func removeUserNotifications(of tasks: [Task]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: tasks.map { $0.id })
    }
    
    private func todayIsDeadline(of task: Task) -> Bool {
        let today = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
        let tomorrow = today + Constants.secondsOfDay
        
        if task.date > today, task.date < tomorrow {
            return true
        }
        return false
    }
    
    func adjustUserNotificationAboutTypeChange(of task: Task) {
        if task.taskType == .done {
            removeUserNotification(of: task)
        } else {
            addUserNotification(of: task)
        }
    }
    
    func adjustUserNotificationAboutModify(of task: Task) {
        if !todayIsDeadline(of: task) {
            removeUserNotification(of: task)
        }
    }
}
