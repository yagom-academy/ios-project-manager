//
//  ContentEditable.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import Foundation

protocol ContentEditable {
    func edit(indexPath: Int, title: String, body: String, date: Date)
}
