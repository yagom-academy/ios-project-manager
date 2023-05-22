//
//  Schedule.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/17.
//

import Foundation

struct Schedule: Hashable {
    let id = UUID()
    let title: String
    let detail: String
    let expirationDate: Date
}
