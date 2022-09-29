//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

final class RegistrationViewModel {

    // MARK: - Properties
    
    private let dataManager: DataManagable
    
    init(dataManager: DataManagable) {
        self.dataManager = dataManager
    }
    
    // MARK: - Functions

    func append(new item: ToDoItem, to type: ProjectType) {
        dataManager.create(with: item, to: type)
    }
}
