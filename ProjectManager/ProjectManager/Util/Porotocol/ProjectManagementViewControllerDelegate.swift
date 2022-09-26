//
//  ProjcetManagebleDelegate.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

protocol ProjectManagementViewControllerDelegate: AnyObject {
    func projectManagementViewController(_ viewController: ProjectManagementViewController,
                                         createData: ProjectViewModel)
    func projectManagementViewController(_ viewController: ProjectManagementViewController,
                                         updateData: ProjectViewModel)
}
