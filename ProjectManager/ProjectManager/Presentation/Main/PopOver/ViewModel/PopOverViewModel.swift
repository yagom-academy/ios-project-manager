//
//  PopOverViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

struct PopOverViewModel {
    private let cell: ProjectCell
    
    init(cell: ProjectCell) {
        self.cell = cell
    }
    
    func moveCell(by text: String?) {
        guard let status = ProjectStatus.convert(text) else {
            return
        }
        changeContent(status: status)
    }
    
    private func changeContent(status: ProjectStatus) {
        guard let id = cell.contentID,
              var project = ProjectUseCase().read(id: id) else {
            return
        }
        
        project.updateStatus(status)
    }
    
    func getStatus() -> (first: ProjectStatus, second: ProjectStatus)? {
        guard let id = cell.contentID,
              let project = ProjectUseCase().read(id: id),
              let status = project.getStatus() else {
            return nil
        }
        
        return convertProcess(by: status)
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
