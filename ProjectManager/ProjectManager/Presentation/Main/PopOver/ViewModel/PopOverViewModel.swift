//
//  PopOverViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import Foundation

struct PopOverViewModel {
    private let cell: ProjectCell
    
    init(cell: ProjectCell) {
        self.cell = cell
    }
    
    func moveCell(by text: String?) {
        guard let status = ProjectStatus.convert(titleText: text) else {
            return
        }
        changeContent(status: status)
    }
    
    private func changeContent(status: ProjectStatus) {
        guard let id = cell.contentID,
              var project = ProjectUseCase().read(id: id) else {
            return
        }
        
        createMoved(from: project.status, to: status, title: project.title)
        
        project.status = status
        
        ProjectUseCase().update(projectContent: project)
    }
    
    private func createMoved(from oldStatus: ProjectStatus, to newStatus: ProjectStatus, title: String) {
        let historyTitle = title + "(from: \(oldStatus.string) to: \(newStatus.string))"
        
        let historyEntity = HistoryEntity(
            editedType: .move,
            title: historyTitle,
            date: Date().timeIntervalSince1970
        )
        
        ProjectUseCase().createHistory(historyEntity: historyEntity)
    }
    
    func getStatus() -> (first: ProjectStatus, second: ProjectStatus)? {
        guard let id = cell.contentID,
              let project = ProjectUseCase().read(id: id) else {
            return nil
        }
        
        return convertProcess(by: project.status)
    }
    
    private func convertProcess(by status: ProjectStatus) -> (first: ProjectStatus, second: ProjectStatus) {
        switch status {
        case .todo:
            return (ProjectStatus.doing, ProjectStatus.done)
        case .doing:
            return (ProjectStatus.todo, ProjectStatus.done)
        case .done:
            return (ProjectStatus.todo, ProjectStatus.doing)
        }
    }
}
