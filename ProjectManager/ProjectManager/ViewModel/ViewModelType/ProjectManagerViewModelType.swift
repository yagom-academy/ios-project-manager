//
//  ProjectManagerViewModelType.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/18.
//

protocol ProjectManagerViewModelType: AnyObject {
    
    // MARK: - Properties
    
    func transform(viewInput: ProjectManagerViewInput) -> ProjectManagerViewOutput
}
