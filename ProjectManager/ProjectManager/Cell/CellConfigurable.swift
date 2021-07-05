//
//  CellConfigurable.swift
//  ProjectManager
//
//  Created by Seungjin Baek on 2021/07/01.
//

import UIKit

protocol CellConfigurable {
    func configure(tasks: [Task], rowAt row: Int)
}
