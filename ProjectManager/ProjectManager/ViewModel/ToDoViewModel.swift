//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class ToDoViewModel {
    var toDoData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return toDoData.value.count
    }

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
        fetchToDoData()
    }

    func addProject(
        title: String,
        body: String,
        date: Date
    ) {
        let project = ProjectUnit(
            id: UUID(),
            title: title,
            body: body,
            section: "TODO",
            deadLine: date
        )
        toDoData.value.append(project)
        try? databaseManager.create(data: project)
    }

    func delete(_ indexPath: Int) {
        let data = toDoData.value.remove(at: indexPath)
        try? databaseManager.delete(id: data.id)
    }

    func fetch(_ indexPath: Int) -> ProjectUnit? {
        toDoData.value[indexPath]
    }

    private func fetchToDoData() {
        do {
            try databaseManager.fetchSection("TODO").forEach { project in
                toDoData.value.append(project)
            }
        } catch {
            print(error)
        }
    }
}
