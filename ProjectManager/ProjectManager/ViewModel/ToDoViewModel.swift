//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class ToDoViewModel: Readjustable, Editable {
    var toDoData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return toDoData.value.count
    }
    
    var message: String = "" {
        didSet {
            guard let showAlert = showAlert else {
                return
            }
            
            showAlert()
        }
    }

    let databaseManager: DatabaseLogic
    
    var showAlert: (() -> Void)?

    init(databaseManager: DatabaseLogic) {
        self.databaseManager = databaseManager
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name.doingToToDo,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name.doneToToDo,
            object: nil
        )
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
            section: ProjectStatus.todo,
            deadLine: date
        )
        toDoData.value.append(project)
        do {
            try databaseManager.create(data: project)
        } catch {
            message = "Add Entity Error"
        }
    }
    
    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }
        
        projectUnit.section = ProjectStatus.todo
        
        toDoData.value.append(projectUnit)
        
        do {
            try databaseManager.update(data: projectUnit)
        } catch {
            message = "Add Error"
        }
    }

    func delete(_ indexPath: Int) {
        let data = toDoData.value.remove(at: indexPath)
        
        do {
            try databaseManager.delete(id: data.id)
        } catch {
            message = "Delete Error"
        }
    }

    func fetch(_ indexPath: Int) -> ProjectUnit? {
        toDoData.value[indexPath]
    }
    
    func readjust(index: Int, section: String) {
        let data = toDoData.value.remove(at: index)
        
        switch section {
        case ProjectStatus.doing:
            NotificationCenter.default.post(name: Notification.Name.toDoToDoing, object: data)
        case ProjectStatus.done:
            NotificationCenter.default.post(name: Notification.Name.toDoToDone, object: data)
        default:
            return
        }
    }

    func edit(
        indexPath: Int,
        title: String,
        body: String,
        date: Date
    ) {
        var data = toDoData.value[indexPath]
        data.title = title
        data.body = body
        data.deadLine = date
        
        toDoData.value[indexPath] = data
        do {
            try databaseManager.update(data: data)
        } catch {
            message = "Edit Error"
        }
    }

    func isPassDeadLine(_ deadLine: Date) -> Bool {
        if deadLine < Date() {
            return true
        }

        return false
    }

    private func fetchToDoData() {
        do {
            try databaseManager.fetchSection(ProjectStatus.todo).forEach { project in
                toDoData.value.append(project)
            }
        } catch {
            message = "Fetch Error"
        }
    }
}
