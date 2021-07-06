//
//  DoingTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/07/04.
//

import UIKit

final class DoingTableViewCell: UITableViewCell {
    static let identifier = "DoingTableViewCellIdentifier"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var doingTitle: UILabel!
    @IBOutlet weak var doingSummary: UILabel!
    @IBOutlet weak var doingDate: UILabel!
}

extension DoingTableViewCell: TableViewCell {
    func update(info: TableItem) {
        doingTitle.text = info.title
        doingSummary.text = info.summary
        
        let stringOfDate = dateConverter.numberToString(number: info.date)
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        doingDate.text = stringOfDate
        doingDate.textColor = stringOfDate < stringOfCurrentDate ? .red : .black
    }
}
