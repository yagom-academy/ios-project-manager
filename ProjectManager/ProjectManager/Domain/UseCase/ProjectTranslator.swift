//
//  ProjectTranslator.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/19.
//

import Foundation

protocol ProjectTranslator {
    func translateToProjectModel(with data: ProjectViewModel) -> ProjectModel
    func translateToProjectViewModel(with data: ProjectModel) -> ProjectViewModel
}

extension ProjectTranslator {
    func translateToProjectModel(with data: ProjectViewModel) -> ProjectModel {
        let model = ProjectModel(id: data.id,
                                 title: data.title,
                                 body: data.body,
                                 date: data.date.toDate(),
                                 workState: data.workState)
        
        return model
    }
    
    func translateToProjectViewModel(with data: ProjectModel) -> ProjectViewModel {
        let model = ProjectViewModel(id: data.id,
                                     title: data.title,
                                     body: data.body,
                                     date: data.date.convertLocalization(),
                                     workState: data.workState)
        
        return model
    }
}
