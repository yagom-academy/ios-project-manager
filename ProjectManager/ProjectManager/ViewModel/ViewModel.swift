//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/15.
//

import Foundation

final class ViewModel {
    private var toDoData: Observable<[ProjectUnit]> = Observable([])
    private var doingData: Observable<[ProjectUnit]> = Observable([])
    private var doneData: Observable<[ProjectUnit]> = Observable([])

    let databaseManager: DatabaseLogic

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
    }
    
    func fetchData() {
        try? databaseManager.fetchSection("TODO").forEach { project in
            toDoData.value.append(project)
        }
        
        try? databaseManager.fetchSection("DOING").forEach { project in
            doingData.value.append(project)
        }
        
        try? databaseManager.fetchSection("DONE").forEach { project in
            doneData.value.append(project)
        }
    }
    
    func addProject(
        title: String,
        body: String,
        date: Date
    ) {
        let project = ProjectUnit(id: UUID(), title: title, body: body, section: "TODO", deadLine: date)
        toDoData.value.append(project)
        try? databaseManager.create(data: project)
    }
    
    func move(
        _ indexPath: Int,
        from currentSection: String,
        to nextSection: String
    ) {
        switch currentSection {
        case "TODO":
            var data = toDoData.value.remove(at: indexPath)
            data.section = nextSection
            move(data: data, to: nextSection)
        case "DOING":
            var data = doingData.value.remove(at: indexPath)
            data.section = nextSection
            move(data: data, to: nextSection)
        case "DONE":
            var data = doneData.value.remove(at: indexPath)
            data.section = nextSection
            move(data: data, to: nextSection)
        default:
            return
        }
    }
    
    func delete(_ indexPath: Int, section: String) {
        switch section {
        case "TODO":
            let data = toDoData.value.remove(at: indexPath)
            try? databaseManager.delete(id: data.id)
        case "DOING":
            let data = doingData.value.remove(at: indexPath)
            try? databaseManager.delete(id: data.id)
        case "DONE":
            let data = doneData.value.remove(at: indexPath)
            try? databaseManager.delete(id: data.id)
        default:
            return
        }
    }
    
    func fetch(_ indexPath: Int, from section: String) -> ProjectUnit? {
        switch section {
        case "TODO":
            return toDoData.value[indexPath]
        case "DOING":
            return doingData.value[indexPath]
        case "DONE":
            return doneData.value[indexPath]
        default:
            return nil
        }
    }
    
    private func move(data: ProjectUnit, to section: String) {
        switch section {
        case "TODO":
            toDoData.value.append(data)
            try? databaseManager.update(data: data)
        case "DOING":
            doingData.value.append(data)
            try? databaseManager.update(data: data)
        case "DONE":
            doneData.value.append(data)
            try? databaseManager.update(data: data)
        default:
            return
        }
    }
}
