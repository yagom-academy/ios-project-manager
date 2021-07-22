//
//  TaskAddDelegate.swift
//  ProjectManager
//
//  Created by Fezravien on 2021/07/22.
//

import Foundation

protocol TaskAddDelegate {
    func addData(_ data: Task)
    func updateData(state: State, indexPath: IndexPath, _ data: Task)
}
