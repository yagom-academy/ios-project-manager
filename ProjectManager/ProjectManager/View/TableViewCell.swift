//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    static let cellIdentifier = "LeftTableViewCell"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func update(info: TableItem) {
        self.backgroundColor = UIColor.clear
        
        title.text = info.title
        summary.text = info.summary
        date.text = dateConverter.numberToString(number: info.date)
        
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        if date.text ?? "" < stringOfCurrentDate {
            date.textColor = UIColor.red
        } else {
            date.textColor = UIColor.black
        }
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

