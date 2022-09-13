//
//  ProjectManagerDataProtocol.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

protocol ProjectManagerDataProtocol: AnyObject {
    func create(data: ProjectDTO)
    func update(id: String, data: ProjectDTO)
}
