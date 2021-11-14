//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/13.
//

import Foundation
import SwiftUI

struct HistoryViewModel {
    private let histroy: History
    private let characterLimit = 15
    
    var modifiedMemoTitle: String {
        if histroy.title.count >= characterLimit {
            return histroy.title.prefix(characterLimit) + "..."
        }
        return histroy.title
    }
    var modifiedDate: Date {
        return histroy.date
    }
    var modifiedType: String {
        return histroy.updateType.description
    }
    var modifiedTypeColor: Color {
        switch histroy.updateType {
        case .modify:
            return .orange
        case .create:
            return .green
        case .delete:
            return .red
        }
    }
    var id: UUID {
        return histroy.id
    }
    
    init(history: History) {
        self.histroy = history
    }
}
