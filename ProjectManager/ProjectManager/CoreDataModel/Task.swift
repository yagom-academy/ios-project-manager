//
//  Task.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//

import Foundation

protocol Task {
    var title: String { get set }
    var body: String { get set }
    var date: Double { get set }
    var status: String { get set }
}
