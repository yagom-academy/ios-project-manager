//
//  Todoable.swift
//  ProjectManager
//
//  Created by LIMGAUI on 2022/07/10.
//

import Foundation

protocol TodoDelegate: AnyObject {
  func createData(_ todo: Todo)
  func updateData(_ todo: Todo)
}
