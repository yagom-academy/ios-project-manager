//
//  PopOverViewModel.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

struct PopOverViewModel {
    let cell: ProjectCell
    
    init(cell: ProjectCell) {
        self.cell = cell
    }
    
    func changeConent(status: ProjectStatus) {
        guard let id = cell.contentID,
              var project = MockStorageManager.shared.read(id: id) else {
            return
        }
        
        project.updateStatus(status)
    }
    func getStatus() -> (first: ProjectStatus, second: ProjectStatus)? {
        guard let cellData = cell.getData() else {
        guard let id = cell.contentID,
            return nil
        }
        
        let status = cellData.getStatus()
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
