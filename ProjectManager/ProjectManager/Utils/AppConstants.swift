//
//  AppConstants.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/12.
//

import Foundation

enum AppConstants {
    static let defaultStringValue: String = ""
    static let defaultDoubleValue: Double = .zero
    static let defaultTaskArrayValue: [Task] = []
    static let pushHistoryNotificationName: String = "PushHistory"
    static let popHistoryNotificationName: String = "PopHistory"
    static let historyContentKey: String = "content"
    static let historyTimeKey: String = "time"
    static let errorAlertTitle: String = "오류"
    static let okActionTitle: String = "확인"
    static let notificationPermissionAlertTitle: String = "알림 권한"
    static let notificationPermissionAlertMessage: String = "서비스를 이용하시려면 알림 권한을 허용해주세요"
}
