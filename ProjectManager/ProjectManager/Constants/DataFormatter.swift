//
//  DataFormatter.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/18.
//

import Foundation

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateStyle = .short
    return dateFormatter
}()
