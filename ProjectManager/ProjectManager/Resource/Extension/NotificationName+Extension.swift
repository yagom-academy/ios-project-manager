//  ProjectManager - NotificationName+Extension.swift
//  created by zhilly on 2023/01/27

import Foundation

extension Notification.Name {
    static let deleted = Notification.Name("Deleted")
    static let added = Notification.Name("Added")
    static let moved = Notification.Name("Moved")
}
