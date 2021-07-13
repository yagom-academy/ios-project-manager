//
//  NewTodoFormDelegata.swift
//  ProjectManager
//
//  Created by kio on 2021/07/06.
//

import UIKit

protocol ProjectManagerDelegate {
    func dataPassing(title: String, date: Double, description: String)
}
