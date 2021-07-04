//
//  DoneTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoneTableViewCell: UITableViewCell {
    static let cellIdentifier = "DoneTableViewCell"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var doneTitle: UILabel!
    @IBOutlet weak var doneSummary: UILabel!
    @IBOutlet weak var doneDate: UILabel!
    
    func update(info: TableItem) {
        self.backgroundColor = UIColor.clear
        
        doneTitle.text = info.title
        doneSummary.text = info.summary
        doneDate.text = dateConverter.numberToString(number: info.date)
        
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        if doneDate.text ?? "" < stringOfCurrentDate {
            doneDate.textColor = UIColor.red
        } else {
            doneDate.textColor = UIColor.black
        }
    }
}
