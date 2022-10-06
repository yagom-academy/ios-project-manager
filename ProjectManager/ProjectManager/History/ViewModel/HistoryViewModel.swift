//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import Foundation

class HistoryViewModel {
    var contents = [HistoryModel]()

    func add(data: [History]) {
        var allHistory = [HistoryModel]()
        data.forEach { history in
            let body = makeBody(history)
            let date = makeDate(history)
            let model = HistoryModel(body: body, date: date)

            allHistory.append(model)
        }

        contents = allHistory
    }

    private func makeBody(_ model: History) -> String {
        var body = model.activity.name
        body += " \'\(model.title)\'"
        body += " from \(model.from)"

        if let to = model.to {
            body += " to \(to)"
        }

        body += "."

        return body
    }

    private func makeDate(_ model: History) -> String {
        let localizedDate = DateFormatter.localizedString(
            from: model.date,
            dateStyle: .long,
            timeStyle: .medium
        )

        return localizedDate
    }
}
