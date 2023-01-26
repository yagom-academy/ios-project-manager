//
//  ProjectDelegate.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/25.
//

protocol ProjectDelegate: AnyObject {
    func create(project: Project)
    func update(project: Project)
    func delete(project: Project)
}
