//
//  ProjectTableHeaderViewModel.swift
//  ProjectManager
//
//  Created by brad on 2022/09/29.
//

import Foundation

final class ProjectTableHeaderViewModel {
    
    private let dataManager: DataManagable
    
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    func count(of type: ProjectType) -> String {
        let count = dataManager.count(with: type).description
        return count
    }
}
