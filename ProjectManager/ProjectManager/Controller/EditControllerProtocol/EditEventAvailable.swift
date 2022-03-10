//
//  EditViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 고은 on 2022/03/04.
//

import Foundation

protocol EditEventAvailable: AnyObject {

    func editViewControllerDidCancel(_ editViewController: EditController)
    func editViewControllerDidFinish(_ editViewController: EditController)
}
