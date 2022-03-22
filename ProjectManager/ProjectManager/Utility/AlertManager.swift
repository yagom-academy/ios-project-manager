//
//  AlertManager.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/22.
//

import SwiftUI

enum AlertManager {
    
    static let errorAlert = Alert(
        title: Text("에러가 발생했어요 🥺"),
        message: Text("앱 종료 후, 개발자에게 문의해주세요"),
        dismissButton: .default(Text("알겠어요"))
    )
}
