//
//  ProjectManagerViewModelType.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/18.
//

protocol ProjectManagerViewModelType: AnyObject {
    
    // MARK: - Properties
    
    func transform(modelInput: ProjectManagerModelInput) -> ProjectManagerModelOutput
    func transform(viewInput: ProjectManagerViewInput) -> ProjectManagerViewOutput
}
