//
//  DoneTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoneTableViewCell: UITableViewCell {
    static let identifier = "DoneTableViewCellIdentifier"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var doneTitle: UILabel!
    @IBOutlet weak var doneSummary: UILabel!
    @IBOutlet weak var doneDate: UILabel!
    
    func update(info: TableItem) {
        doneTitle.text = info.title
        doneSummary.text = info.summary
        
        let stringOfDate = dateConverter.numberToString(number: info.date)
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        doneDate.text = stringOfDate
        doneDate.textColor = stringOfDate < stringOfCurrentDate ? .red : .black
    }
}
