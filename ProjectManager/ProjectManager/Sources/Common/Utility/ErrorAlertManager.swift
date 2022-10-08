//
//  ErrorAlertManager.swift
//  ProjectManager
//
//  Created by minsson on 2022/10/08.
//

import SwiftUI

struct ErrorAlertManager {
    static var error: LogicError = .unknown
    
    static func recieve(_ error: LogicError) {
        Self.error = error
    }
    
    static func presentError() -> Alert {
        Alert(
            title: Text("에러가 발생했어요 🥲"),
            message: Text("\(error.description) 작업 중이었어요.\n개발자에게 연락 부탁드려요! 😭 빠르게 해결해드릴게요!"),
            dismissButton: .cancel(Text("알겠어요!"))
        )
    }
}
