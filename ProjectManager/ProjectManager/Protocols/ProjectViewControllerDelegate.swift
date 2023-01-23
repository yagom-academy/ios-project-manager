//
//  ProjectViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/24.
//

protocol ProjectViewControllerDelegate {
    func projectViewController(_ projectViewController: ProjectViewController, didUpdateProject: Project)
}
