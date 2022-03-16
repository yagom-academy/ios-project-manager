//
//  ProjectTableViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/09.
//

import Foundation

protocol ProjectTableViewControllerDelegate: AnyObject {
    
    func readProject(of status: Status) -> [Project]?
    
    func updateProject(of identifier: UUID, with content: [String: Any])
    
    func updateProjectStatus(of identifier: UUID, with status: Status)
    
    func deleteProject(of identifier: UUID)
}
