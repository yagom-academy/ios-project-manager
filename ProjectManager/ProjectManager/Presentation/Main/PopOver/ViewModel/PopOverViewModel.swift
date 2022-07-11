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
    
    func getStatus() -> (first: String, second: String)? {
        guard let cellData = cell.getData() else {
            return nil
        }
        
        let status = cellData.getStatus()
        return convertProcess(by: status)
    }
    
    private func convertProcess(by status: ProjectStatus) -> (first: String, second: String) {
        switch status {
        case .todo:
            return (ProjectStatus.doing.string, ProjectStatus.done.string)
        case .doing:
            return (ProjectStatus.todo.string, ProjectStatus.done.string)
        case .done:
            return (ProjectStatus.todo.string, ProjectStatus.doing.string)
        }
    }
}
