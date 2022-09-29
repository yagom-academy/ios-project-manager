//
//  ProjectTableViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class ProjectTableViewModel {
    
    // MARK: - Properties
    
    private let dataManager: DataManagable
    
    lazy var projectHeaderViewModel = ProjectTableHeaderViewModel(dataManager: dataManager)
    lazy var projectDetailViewModel = ProjectDetailViewModel(dataManager: dataManager)
    lazy var alertViewModel = AlertViewModel(dataManager: dataManager)
    
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions

    func count(of type: ProjectType) -> Int {
        return dataManager.count(with: type)
    }
    
    func searchContent(from index: Int, of type: ProjectType) -> ToDoItem {
        return dataManager.read(from: index, of: type)
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        dataManager.update(item: item, from: index, of: type)
    }
    
    func delete(from index: Int, of type: ProjectType) {
        dataManager.delete(index: index, with: type)
    }
}
