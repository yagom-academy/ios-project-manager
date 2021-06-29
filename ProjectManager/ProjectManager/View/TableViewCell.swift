//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    static let cellIdentifier = "LeftTableViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func update(info: TableItem) {
        title.text = info.title
        summary.text = info.summary
        date.text = info.date
    }
}

class CenterTableViewCell: UITableViewCell {
    static let cellIdentifier = "CenterTableViewCell"
    
    @IBOutlet weak var label: UILabel!
}

class RightTableViewCell: UITableViewCell {
    static let cellIdentifier = "RightTableViewCell"
    
    @IBOutlet weak var label: UILabel!
}

