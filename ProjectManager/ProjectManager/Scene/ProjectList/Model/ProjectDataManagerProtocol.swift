//
//  ProjectDataManagerProtocol.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

protocol ProjectDataManagerProtocol: AnyObject {
    func create(data: ProjectModel)
    func update(id: String,
                data: ProjectModel)
}
