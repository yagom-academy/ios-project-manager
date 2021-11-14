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
    
    var modifiedMemoTitle: String {
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
            return .pink
        case .delete:
            return .red
        }
    }
    
    init(history: History) {
        self.histroy = history
    }
}
