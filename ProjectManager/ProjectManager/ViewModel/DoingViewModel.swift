//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

final class DoingViewModel:
    CommonViewModelLogic,
    ContentEditable,
    StatusChangable
{
    let identifier: String = ProjectStatus.doing
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
    }
    
    @objc func addData(_ notification: Notification) {
        guard var projectUnit = notification.object as? ProjectUnit else {
            return
        }
        
        projectUnit.section = identifier
        
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
        case ProjectStatus.todo:
            NotificationCenter.default.post(name: Notification.Name.doingToToDo, object: data)
        case ProjectStatus.done:
            NotificationCenter.default.post(name: Notification.Name.doingToDone, object: data)
        default:
            return
        }
    }
}
