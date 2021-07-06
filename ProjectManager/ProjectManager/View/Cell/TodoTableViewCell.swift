//
//  TodoTableViewCell.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    static let identifier = "TODOTableViewCellIdentifier"
    private let dateConverter = DateConverter()
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSummary: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    
    func update(info: TableItem) {
        todoTitle.text = info.title
        todoSummary.text = info.summary
        
        let stringOfDate = dateConverter.numberToString(number: info.date)
        let stringOfCurrentDate = dateConverter.dateToString(date: Date())
        todoDate.text = stringOfDate
        todoDate.textColor = stringOfDate < stringOfCurrentDate ? .red : .black
    }
}
