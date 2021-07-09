//
//  CellConfigurable.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/07/01.
//

import UIKit

protocol CellConfigurable {
    func configure(tasks: [Task], rowAt row: Int)
    func isOutDated(date: Date) -> Bool
}
