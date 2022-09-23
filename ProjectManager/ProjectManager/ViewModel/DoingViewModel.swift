//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class DoingViewModel: StatusChangable, ContentEditable {
    var doingData: Observable<[ProjectUnit]> = Observable([])
    
    var count: Int {
        return doingData.value.count
    }
    
    var message: String = "" {
        didSet {
            guard let showAlert = showAlert else {
                return
            }
            
            showAlert()
        }
    }
    
    let databaseManager: LocalDatabaseManager
    
    var showAlert: (() -> Void)?

    init(databaseManager: LocalDatabaseManager) {
        self.databaseManager = databaseManager
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name.toDoToDoing,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addData(_:)),
            name: Notification.Name.doneToDoing,
            object: nil
        )
        fetchDoingData()
    }
    
    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }
        
        projectUnit.section = ProjectStatus.doing
        
        doingData.value.append(projectUnit)
        
        do {
            try databaseManager.update(data: projectUnit)
        } catch {
            message = "Add Error"
        }
    }

    func delete(_ indexPath: Int) {
        let data = doingData.value.remove(at: indexPath)
        
        do {
            try databaseManager.delete(id: data.id)
        } catch {
            message = "Delete Error"
        }
    }

    func fetch(_ indexPath: Int) -> ProjectUnit? {
        doingData.value[indexPath]
    }

    func change(index: Int, status: String) {
        let data = doingData.value.remove(at: index)

        switch status {
        case ProjectStatus.todo:
            NotificationCenter.default.post(name: Notification.Name.doingToToDo, object: data)
        case ProjectStatus.done:
            NotificationCenter.default.post(name: Notification.Name.doingToDone, object: data)
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
        var data = doingData.value[indexPath]
        data.title = title
        data.body = body
        data.deadLine = date
        
        doingData.value[indexPath] = data
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

    private func fetchDoingData() {
        do {
            try databaseManager.fetchSection(ProjectStatus.doing).forEach { project in
                doingData.value.append(project)
            }
        } catch {
            message = "Fetch Error"
        }
    }
}
