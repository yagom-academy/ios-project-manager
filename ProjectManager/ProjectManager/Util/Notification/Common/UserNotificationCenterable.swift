//
//  UserNotificationCenterable.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/26.
//

import UserNotifications

protocol UserNotificationCenterable {
  func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
  func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?)
  func removePendingNotificationRequests(withIdentifiers: [String])
  func removeAllPendingNotificationRequests()
}

extension UNUserNotificationCenter: UserNotificationCenterable {}
