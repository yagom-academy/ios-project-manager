//
//  TaskDTO.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/05.
//

import FirebaseFirestoreSwift
import Foundation

struct TaskDTO: Codable {
    var id: String
    var title: String
    var content: String
    var date: Date
    var state: Int
}
