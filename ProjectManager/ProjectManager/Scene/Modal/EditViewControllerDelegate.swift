//
//  EditViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/04.
//

import Foundation

protocol EditViewControllerDelegate: AnyObject {

    func editViewControllerDidCancel(_ editViewController: EditViewController)
    func editViewControllerDidFinish(_ editViewController: EditViewController)
}
