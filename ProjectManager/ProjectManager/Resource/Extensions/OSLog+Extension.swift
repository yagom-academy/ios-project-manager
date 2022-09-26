//
//  OSLog+Extension.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/18.
//

import OSLog

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let ui = OSLog(subsystem: subsystem, category: "UI")
}
