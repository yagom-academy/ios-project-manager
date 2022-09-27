//
//  ContentAddible.swift
//  ProjectManager
//
//  Created by 전민수 on 2022/09/23.
//

import Foundation

protocol ContentAddible {
    var calledContentsOfAddition: String? { get set }
    var registerAdditionHistory: ((String) -> Void)? { get set }

    mutating func addContent(title: String, body: String, date: Date)
}

extension ContentAddible where Self: CommonViewModelLogic {
    mutating func addContent(
        title: String,
        body: String,
        date: Date
    ) {
        let project = ProjectUnit(
            id: UUID(),
            title: title,
            body: body,
            section: ProjectStatus.todo,
            deadLine: date
        )

        calledContentsOfAddition = title

        data.value.append(project)
        do {
            try databaseManager.create(data: project)
        } catch {
            message = "Add Entity Error"
        }
    }
}
