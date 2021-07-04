//
//  DoingTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoingTableViewCell: UITableViewCell {
    static let cellIdentifier = "DoingTableViewCell"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var doingTitle: UILabel!
    @IBOutlet weak var doingSummary: UILabel!
    @IBOutlet weak var doingDate: UILabel!
    
    func update(info: TableItem) {
        self.backgroundColor = UIColor.clear
        
        doingTitle.text = info.title
        doingSummary.text = info.summary
        doingDate.text = dateConverter.numberToString(number: info.date)
        
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        if doingDate.text ?? "" < stringOfCurrentDate {
            doingDate.textColor = UIColor.red
        } else {
            doingDate.textColor = UIColor.black
        }
    }
}
