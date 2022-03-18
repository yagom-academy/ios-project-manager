//
//  ProjectListViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/09.
//

import Foundation

protocol ProjectListViewControllerDelegate: AnyObject {
    
    func readProject(of status: Status) -> [Project]?
    
    func updateProject(of identifier: String, with content: [String: Any])
    
    func updateProjectStatus(of identifier: String, with status: Status)
    
    func deleteProject(of identifier: String)
}
