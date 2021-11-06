//
//  MemoRowViewModel.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/07.
//

import SwiftUI

final class MemoRowViewModel: ObservableObject {
    @Published private(set) var memo: Memo

    private let dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.locale = Locale.current
        result.dateStyle = .medium
        result.timeStyle = .none
        return result
    }()

    init(memo: Memo) {
        self.memo = memo
    }

    func yyyyMMdd(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func color(about memo: Memo) -> Color {
        guard memo.state != .done else {
            return .black
        }

        let currentDate = yyyyMMdd(from: Date())
        let describedDate = yyyyMMdd(from: memo.date)

        if let currentTime = dateFormatter.date(from: currentDate),
           let describedTime = dateFormatter.date(from: describedDate),
           describedTime < currentTime {
            return .red
        } else {
            return .black
        }
    }
}
