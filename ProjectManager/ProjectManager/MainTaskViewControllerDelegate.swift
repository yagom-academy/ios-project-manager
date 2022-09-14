//
//  MainTaskViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

protocol MainTaskViewControllerDelegate: AnyObject {
    func didFinishSaveData(content: TaskModelDTO)
    func didFinishEditData(content: TaskModelDTO)
}
