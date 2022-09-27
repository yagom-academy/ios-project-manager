//
//  ToDoViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class ToDoViewModel:
    CommonViewModelLogic,
    ContentAddible,
    ContentEditable,
    StatusChangable
{
    let identifier: String = ProjectStatus.todo
    let data: Observable<[ProjectUnit]> = Observable([])
    let databaseManager: LocalDatabaseManager
    
    var message: String = "" {
        didSet {
            guard let showAlert = self.showAlert else {
                return
            }
            showAlert()
        }
    }
    
    var showAlert: (() -> Void)?

    var calledContentsOfAddition: String? {
        didSet {
            guard let registerAdditionHistory = self.registerAdditionHistory,
                  let newProject = calledContentsOfAddition else {
                return
            }

            registerAdditionHistory(newProject)
        }
    }

    var calledContentsOfMoving: (String, String)? {
        didSet {
            guard let registerMovingHistory = self.registerMovingHistory,
                  let changes = calledContentsOfMoving else {
                return
            }

            let locationChange = changes.1.components(separatedBy: ["t", "o"])

            registerMovingHistory(changes.0, locationChange[0], locationChange[1])
        }
    }

    var calledContentsOfDeletion: (String, String)? {
        didSet {
            guard let registerDeletionHistory = self.registerDeletionHistory,
                  let removedProject = calledContentsOfDeletion else {
                return
            }

            registerDeletionHistory(removedProject.0, removedProject.1)
        }
    }

    var registerAdditionHistory: ((String) -> Void)?
    var registerDeletionHistory: ((String, String) -> Void)?
    var registerMovingHistory: ((String, String, String) -> Void)?

    init(databaseManager: LocalDatabaseManager) {
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
    }
    
    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }
        
        projectUnit.section = identifier

        calledContentsOfMoving = (projectUnit.title, notification.name.rawValue)
        
        self.data.value.append(projectUnit)
        
        do {
            try databaseManager.update(data: projectUnit)
        } catch {
            message = "Add Error"
        }
    }

    func change(index: Int, status: String) {
        let data = data.value.remove(at: index)
        
        switch status {
        case ProjectStatus.doing:
            NotificationCenter.default.post(name: Notification.Name.toDoToDoing, object: data)
        case ProjectStatus.done:
            NotificationCenter.default.post(name: Notification.Name.toDoToDone, object: data)
        default:
            return
        }
    }
}
