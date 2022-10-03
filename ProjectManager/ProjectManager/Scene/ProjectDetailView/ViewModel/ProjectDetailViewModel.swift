//
//  ProjectDetailViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/23.
//

import Foundation

class ProjectDetailViewModel {
    
    private let dataManager: DataManagable
    
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    func append(new item: ToDoItem, to type: ProjectType) {
        dataManager.create(with: item, to: type)
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        dataManager.update(item: item, from: index, of: type)
    }
}
