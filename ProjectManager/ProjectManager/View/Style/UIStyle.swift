//
//  UIStyle.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/01.
//

import SwiftUI
import CoreGraphics

enum UIStyle {
    static let shadowAmount: CGFloat = 3.0
    static let minInsetAmount: CGFloat = 4.0
    static let buttonWidth: CGFloat = 60.0

    static private let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.locale = Locale.current
        result.dateStyle = .medium
        result.timeStyle = .none
        return result
    }()

    static func yyyyMMdd(about date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    static func color(about memo: Memo) -> Color {
        guard memo.state != .done else {
            return .black
        }

        let currentDate = yyyyMMdd(about: Date())
        let describedDate = yyyyMMdd(about: memo.date)

        if let currentTime = dateFormatter.date(from: currentDate),
           let describedTime = dateFormatter.date(from: describedDate),
           describedTime < currentTime {
            return .red
        } else {
            return .black
        }
    }
}
