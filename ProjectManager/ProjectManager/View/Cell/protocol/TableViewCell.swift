//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/06.
//

import UIKit

protocol TableViewCell: UITableViewCell {
    func update(info: ViewInfo)
}
