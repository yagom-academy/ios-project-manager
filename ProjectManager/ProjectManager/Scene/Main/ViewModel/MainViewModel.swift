//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    
    private let dataManager: DataManagable
    
    lazy var registrationViewModel = RegistrationViewModel(dataManager: dataManager)
    lazy var projectTableViewModel = ProjectTableViewModel(dataManager: dataManager)
    
    // MARK: - Initializers
    
    init(with dataManager: DataManagable) {
        self.dataManager = dataManager
    }
}
