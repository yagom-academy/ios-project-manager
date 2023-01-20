//
//  ViewModelDelegate.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/20.
//

protocol ViewModelDelegate: AnyObject {
    func addProject(_ project: Project?)
    func updateProject(_ project: Project?)
}
