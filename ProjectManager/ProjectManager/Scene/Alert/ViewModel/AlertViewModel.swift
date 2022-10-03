//
//  AlertViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class AlertViewModel {
    
    // MARK: - Properties

    private let dataManager: DataManagable
    
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions

    func searchContent(from index: Int, of type: ProjectType) -> ToDoItem {
        dataManager.read(from: index, of: type)
    }
    
    func append(new item: ToDoItem, to type: ProjectType) {
        dataManager.create(with: item, to: type)
    }
    
    func delete(from index: Int, of type: ProjectType) {
        dataManager.delete(index: index, with: type)
    }
    
    func move(project: ProjectType, in index: IndexPath, to anotherProject: ProjectType) {
        let movingContent = searchContent(from: index.row, of: project)

        append(new: movingContent, to: anotherProject)
        delete(from: index.row, of: project)
    }
}
