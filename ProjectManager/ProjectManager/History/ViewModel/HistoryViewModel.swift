//
//  HistoryViewModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/28.
//

import Foundation

class HistoryViewModel {
    var contents = [HistoryModel]()

    func add(data: SendModel) {
        let body = makeBody(data)
        let date = makeDate(data)
        let model = HistoryModel(body: body, date: date)

        contents.append(model)
    }

    private func makeBody(_ model: SendModel) -> String {
        var body = model.activity.name
        body += " \'\(model.title)\'"
        body += " from \(model.from)"

        if let to = model.to {
            body += " to \(to)"
        }

        body += "."

        return body
    }

    private func makeDate(_ model: SendModel) -> String {
        let localizedDate = DateFormatter.localizedString(
            from: model.date,
            dateStyle: .long,
            timeStyle: .medium
        )

        return localizedDate
    }
}
