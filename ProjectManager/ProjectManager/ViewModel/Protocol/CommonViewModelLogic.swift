//
//  CommonViewModelLogic.swift
//  ProjectManager
//
//  Created by 전민수 on 2022/09/23.
//

import Foundation

protocol CommonViewModelLogic: AnyObject {
    var identifier: String { get }
    var data: Observable<[ProjectUnit]> { get }
    var databaseManager: LocalDatabaseManager { get }
    var count: Int { get }
    var otherTitles: [String] { get }
    var message: String { get set }
    var showAlert: (() -> Void)? { get set }

    func delete(_ indexPath: Int)
    func isPassDeadLine(_ deadLine: Date) -> Bool
}

extension CommonViewModelLogic {
    var count: Int {
        return data.value.count
    }
    
    var otherTitles: [String] {
        return [ProjectStatus.todo, ProjectStatus.doing, ProjectStatus.done].filter {
            $0 != self.identifier
        }
    }

    func delete(_ indexPath: Int) {
        let data = data.value.remove(at: indexPath)

        do {
            try databaseManager.delete(id: data.id)
        } catch {
            message = "Delete Error"
        }
    }
    
    func isPassDeadLine(_ deadLine: Date) -> Bool {
        if deadLine < Date() {
            return true
        }

        return false
    }

    private func fetchProjectData() {
        do {
            try databaseManager.fetchSection(identifier).forEach { project in
                data.value.append(project)
            }
        } catch {
            message = "Fetch Error"
        }
    }
}
