//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let cellIdentifier = "TableViewCell"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSummary: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    
    @IBOutlet weak var doingTitle: UILabel!
    @IBOutlet weak var doingSummary: UILabel!
    @IBOutlet weak var doingDate: UILabel!
    
    @IBOutlet weak var doneTitle: UILabel!
    @IBOutlet weak var doneSummary: UILabel!
    @IBOutlet weak var doneDate: UILabel!
    
    func update(info: TableItem) {
        self.backgroundColor = UIColor.clear
        
        todoTitle.text = info.title
        todoSummary.text = info.summary
        todoDate.text = dateConverter.numberToString(number: info.date)
        
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        if todoDate.text ?? "" < stringOfCurrentDate {
            todoDate.textColor = UIColor.red
        } else {
            todoDate.textColor = UIColor.black
        }
    }
}
